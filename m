Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286711AbRL1Dbt>; Thu, 27 Dec 2001 22:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbRL1Dbj>; Thu, 27 Dec 2001 22:31:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15367
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286711AbRL1Dba>; Thu, 27 Dec 2001 22:31:30 -0500
Date: Thu, 27 Dec 2001 19:29:29 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Guest section DW <dwguest@win.tue.nl>, James Stevenson <mistral@stev.org>,
        jlladono@pie.xtec.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <200112272304.AAA05151@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.10.10112271926400.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have it called "STROKE".

Use a patch and execute a soft-clip operation to the device and you are
fixed.  To bad the kernel maintainers do not see value in this or any
other driver that follows the standards for the physical layers.

Regards,

On Fri, 28 Dec 2001, Stephan von Krawczynski wrote:

> > On Thu, Dec 27, 2001 at 07:51:01PM +0100, Stephan von Krawczynski   
> wrote:                                                                
> >                                                                     
> > > I don't know. I tried once with                                   
> > >                                                                   
> > > 00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> (rev d0)                                                              
> > >                                                                   
> > > and it did not work. I could definitely not write beyond the 32 GB
> border. I                                                             
> > > replaced the mobo then.                                           
> >                                                                     
> > Did you try setmax?                                                 
>                                                                       
> unfortunately not, I did not even know it existed before this thread. 
> I must admit I have still not had a look at it, but on the other hand:
> if it makes big IDE drives work on old mobo & bios, it may be a good  
> idea to include its intelligence into the kernel, or not?             
> Yes, I know that people nowadays tend to strip down _old_ stuff from  
> the current sources, but I guess it is not a big loss in code size    
> either, is it?                                                        
> knock, knock .. hello IDE maintainer, how about a Xmas present ?      
> :-)                                                                   
>                                                                       
> Regards,                                                              
> Stephan                                                               
>                                                                       
>                                                                       
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

