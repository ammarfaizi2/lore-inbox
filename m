Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132435AbRAXEmm>; Tue, 23 Jan 2001 23:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132489AbRAXEmc>; Tue, 23 Jan 2001 23:42:32 -0500
Received: from feral.com ([192.67.166.1]:35184 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S132435AbRAXEmP>;
	Tue, 23 Jan 2001 23:42:15 -0500
Date: Tue, 23 Jan 2001 20:41:53 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Matt_Domsch@Dell.com
cc: ttsig@tuxyturvy.com, linux-kernel@vger.kernel.org
Subject: RE: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9C0C@ausxmrr501.us.dell.com>
Message-ID: <Pine.BSF.4.21.0101232041310.5712-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jan 2001 Matt_Domsch@Dell.com wrote:

> Hi Tom.  Thanks for writing.
> 
> > Since this machine has Quantum drives I guess this is my 
> > problem.  Does anyone 
> > know if this code is still actually necessary?  It seems 
> > it's been there a 
> > while.  It's disappointing to not get full performance out of 
> > the hardware you 
> > have.
> 
> Yes, that code is still necessary.  There's a new aic7xxx driver by Justin
> Gibbs at Adaptec which is now being beta tested which corrects this issue.
> Something to note, however: the media transfer rate for those disks is at
> most ~20MB/sec. 


Actually, aren't a number of newer drives getting upwards of 30MB/s?

> Therefore, you only exceed the 80MB/sec bus speed if you
> have more than 4 disks all doing maximum I/O at the same time.  Since the
> PowerApp.web 100 has at most 2 disks internally, you really shouldn't see
> any significant performance difference.
> 
> Hope this helps.
> Thanks for buying Dell!
> Matt Domsch
> Dell Linux Systems Group
> Linux OS Development
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
