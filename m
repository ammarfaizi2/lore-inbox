Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285342AbRLGAay>; Thu, 6 Dec 2001 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285337AbRLGAao>; Thu, 6 Dec 2001 19:30:44 -0500
Received: from ns.ithnet.com ([217.64.64.10]:13075 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285338AbRLGAac>;
	Thu, 6 Dec 2001 19:30:32 -0500
Message-Id: <200112070012.BAA24810@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Fri, 07 Dec 2001 01:12:53 +0100
Subject: Re: Linux 2.4.17-pre5
To: Luca Montecchiani <m.luca@iname.com>
In-Reply-To: <3C0FD89A.10B28C7B@iname.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: marcelo@conectiva.com.br, Linux Kernel <linux-kernel@vger.kernel.org>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hisax compile fix :                                                 
>                                                                     
> --- drivers/isdn/hisax/config.c.orig    Thu Dec  6 21:34:23 2001    
> +++ drivers/isdn/hisax/config.c Thu Dec  6 21:34:31 2001            
> @@ -485,7 +485,7 @@                                                 
>                 if (strlen(str) < HISAX_IDSIZE)                     
>                         strcpy(HiSaxID, str);                       
>                 else                                                
> -                       printk(KERN_WARNING "HiSax: ID too long!")  
> +                       printk(KERN_WARNING "HiSax: ID too long!"); 
>         } else                                                      
>                 strcpy(HiSaxID, "HiSax");                           
>                                                                     
>                                                                     
                                                                      
Ah, shit. Thanks luca, this was my fault. Never cut'n'paste via mouse 
on important occasions.                                               
Sorry guys, this was my fault, not Marcelo's.                         
                                                                      
BTW, for the further ongoing of this patch, I ran into the question if
                                                                      
                                                                      
MODULE_PARM(type, "1-(16)i");                                         
                                                                      
would be a valid statement. I guess not. But if not, could some kind  
soul please explain to me how to get rid of the braces "(" ")" given  
in definitions from CONFIG stuff.                                     
                                                                      
E.g.:                                                                 
                                                                      
CONFIG_ME_BEING_DUMB (16)                                             
                                                                      
entering above MODULE_PARM contruction via a definition. I searched   
the source tree a bit, but did not find any hints.                    
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
PS: I _will_ re-check the next patches several times, I swear ... :-) 
                                                                      
                                                                      
                                                                      
                                                                      
