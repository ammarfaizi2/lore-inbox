Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSADAUB>; Thu, 3 Jan 2002 19:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288416AbSADATv>; Thu, 3 Jan 2002 19:19:51 -0500
Received: from ns.ithnet.com ([217.64.64.10]:36370 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288414AbSADATg>;
	Thu, 3 Jan 2002 19:19:36 -0500
Message-Id: <200201040019.BAA30736@webserver.ithnet.com>
Cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Date: Fri, 04 Jan 2002 01:19:28 +0100
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, I lost the response that basically said "2.4 looks   
stable                                                                
> to me", but let me count the ways in which I agree with Andreas'    
> sentiment:                                                          
>                                                                     
> A) VM has major issues                                              
                                                                      
On all boxes I run currently (all 1GB or below RAM), I cannot find    
_major_ issues.                                                       
                                                                      
> 2) VM falls down on large-memory machines with a                    
>    high inode count (slocate/updatedb, i/dcache)                    
                                                                      
Must be beyond the GB range.                                          
                                                                      
> 3) Memory allocation failures and OOM triggers                      
>    even though caches remain full.                                  
                                                                      
I have not had one up to now in everyday life with 2.4.17             
                                                                      
> 4) Other bugs fixed in -aa and others                               
                                                                      
Hm, well I would expect Andrea to do tuning and fixing as experience  
evolves...                                                            
                                                                      
> B) Live- and dead-locks that I'm seeing on all 2.4 production       
> 	   machines > 2.4.9, possibly related to A.  But how will I        
> 	   ever find out?                                                  
                                                                      
Me = none up to now I could track down to a kernel issue. The single  
one I had was with a distro kernel around 2.4.10 and flaky hardware.  
                                                                      
> C) IO-APIC code that requires noapic on any and all SMP             
>   machines that I've ever run on.                                   
                                                                      
I am currently running 5 Asus CUV4X-D based SMP boxes all with apic   
_on_, amongst  which are squids, sql servers, workstation type setups 
(2 my very own).                                                      
                                                                      
> I don't have anything against anyone here -- I think everyone is    
doing a                                                               
> fine job.  It's an issue of acceptance of the problem and focus.    
These                                                                 
> issues are all showstoppers for me, and while I don't represent the 
90%                                                                   
> of the Linux market that is UP desktops, IMHO future work on the    
kernel                                                                
> will be degraded by basic functionality that continues to cause     
> problems.                                                           
                                                                      
Have you run _yourself_ into a problem with 2.4.17?                   
I mean it is not perfect of course, but it is far better than you make
it look.                                                              
I could hand the brown bag to all versions below about 2.4.15  pretty 
easy, but since 2.4.16 it has really become hard to shoot it down for 
me. Ok, I use only pretty selected hardware, but there are reasons I  
do, and they are not related to the kernel in first place.            
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
