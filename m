Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285668AbRL3XVq>; Sun, 30 Dec 2001 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285669AbRL3XVg>; Sun, 30 Dec 2001 18:21:36 -0500
Received: from ns.ithnet.com ([217.64.64.10]:34318 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285668AbRL3XVU>;
	Sun, 30 Dec 2001 18:21:20 -0500
Message-Id: <200112302320.AAA10992@webserver.ithnet.com>
Cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 31 Dec 2001 00:20:29 +0100
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
To: Davide Libenzi <davidel@xmailserver.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.40.0112301212540.935-100000@blue1.dev.mcafeelabs.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 30 Dec 2001, Timothy Covell wrote:                          
>                                                                     
> > each CPU?   And this reminds me of how "make -j3 bzlilo" is slower
than                                                                  
> > "make -j2 bzlilo".                                                
>                                                                     
> Running N CPU bound tasks on an M way SMP machine with N > M is     
never                                                                 
> going to improve your performace. On the contrary, expecially with  
the                                                                   
> current scheduler that keeps rotating the three tasks between the   
two                                                                   
> CPUs, you're going to suffer a slight performance degradation.      
                                                                      
And can you please post a patch for this?                             
                                                                      
;-)                                                                   
                                                                      
Honestly: it _should_ be fixed, there is a better way of doing it, and
this is the base for a patch.                                         
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
