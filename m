Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSAPAa1>; Tue, 15 Jan 2002 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSAPAaR>; Tue, 15 Jan 2002 19:30:17 -0500
Received: from ns.ithnet.com ([217.64.64.10]:54544 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289794AbSAPAaG>;
	Tue, 15 Jan 2002 19:30:06 -0500
Message-Id: <200201160029.BAA06423@webserver.ithnet.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Date: Wed, 16 Jan 2002 01:29:30 +0100
Subject: Re: Linux 2.4.18-pre4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> So here goes pre4.                                                  
                                                                      
aehm, did I spoil it myself, or is it someone else:                   
                                                                      
compiling .... and then:                                              
                                                                      
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} 
pcmcia                                                                
if [ -r System.map ]; then /sbin/depmod -ae -F System.map             
2.4.18-pre4; fi                                                       
depmod: *** Unresolved symbols in                                     
/lib/modules/2.4.18-pre4/kernel/fs/minix/minix.o                      
depmod:         waitfor_one_page                                      
                                                                      
..config was taken over from 2.4.17, where it was working.             
                                                                      
??                                                                    
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
