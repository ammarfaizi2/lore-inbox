Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287875AbSAHBoM>; Mon, 7 Jan 2002 20:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSAHBoA>; Mon, 7 Jan 2002 20:44:00 -0500
Received: from ns.ithnet.com ([217.64.64.10]:8201 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287876AbSAHBns>;
	Mon, 7 Jan 2002 20:43:48 -0500
Message-Id: <200201080143.CAA19970@webserver.ithnet.com>
Cc: andihartmann@freenet.de, linux-kernel@vger.kernel.org
Date: Tue, 08 Jan 2002 02:43:42 +0100
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: Petro <petro@auctionwatch.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <20020107202927.GC1227@auctionwatch.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 07, 2002 at 03:33:48PM +0100, Stephan von Krawczynski   
wrote:                                                                
> > mysql question: is this a binary from some distro or              
self-compiled? If                                                     
> > self-compiled can you show your ./configure paras, please?        
>                                                                     
>     It's the binary from mysql.com.                                 
                                                                      
Beta or stable release?                                               
                                                                      
> > [...] I would try Martins small VM patch, as it looks like being a
bit                                                                   
> > more efficient in low mem conditions and this may well be the case
you are                                                               
> > running into. This means 2.4.17 standard + patch.                 
>                                                                     
>      Is there a reasonable chance that martins patch will get       
mainlined                                                             
>      in the near future?                                            
                                                                      
I really can't know. But to me the results look interesting enough to 
give it a try on certain problem situations (like yours) to find out  
if it is any better than the stock version. If you and others can     
confirm that things get better then I have no real doubts that Marcelo
can pick it up.                                                       
                                                                      
> One of the big reasons I chose to upgrade to a                      
>      later kernel version (from 2.4.8ac<something>+LVMpatches+...)  
was                                                                   
>      to get away from having to apply patches (and document which   
>      patches and where to get them etc).                            
                                                                      
Well, there is really nothing wrong with upgrading mainline kernels,  
as the are getting better with every release, so I would always       
suggest to take the releases up lets say a week after being out. Only 
your situation maybe can help to improve more, if you input some of   
your experiences in LKML with a patch like Martins. Feedback _is_     
required to find a solution to an existing problem.                   
                                                                      
>      If this is the route I have to go, I'll do it but, well, I'm   
not                                                                   
>      that comfortable with it.                                      
                                                                      
Well, my suggestions: don't patch around too much, but try single     
patches on stock kernel and evaluate them here.                       
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
