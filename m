Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132324AbRDAMSU>; Sun, 1 Apr 2001 08:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDAMSL>; Sun, 1 Apr 2001 08:18:11 -0400
Received: from www.inreko.ee ([195.222.18.2]:32504 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S132324AbRDAMR6>;
	Sun, 1 Apr 2001 08:17:58 -0400
Date: Sun, 1 Apr 2001 14:31:38 +0200
From: Marko Kreen <marko@l-t.ee>
To: Earle Nietzel <nietzel@yahoo.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Minor 2.4.3 Adaptec Driver Problems
Message-ID: <20010401143138.A22774@l-t.ee>
In-Reply-To: <200103312307.f2VN73s55018@aslan.scsiguy.com> <000901c0bae7$ab340a20$1401a8c0@nietzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c0bae7$ab340a20$1401a8c0@nietzel>; from nietzel@yahoo.com on Sun, Apr 01, 2001 at 01:09:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 01:09:30PM -0700, Earle Nietzel wrote:
> > Umm.  This isn't an aic7xxx driver problem at all.  The SCSI layer
> > determines the order of bus attachment *amongst* the various
> > SCSI HBA (or SCSI HBA like) drivers in the system.  In this case,
> > it has decided to probe your IDE devices as SCSI devices first.
> > Why it does this I don't really know (link order perhaps???).  One
> > way around this would be to put your IDE driver into an initial
> > ram disk and compile the aic7xxx driver directly into the kernel.


> It really wouldn't make a big deal but I consider my cdroms and zip drives
> to be removable devices and if I ever decided to remove my zip my scsi ids
> will change. Removing a harddrive is not the same as removing a zip!
> 
> Are there other people with the same problem?

Yes, I have ide-scsi compiled in for cd-writer, so 2.4.3 did not
boot on my machine (that is, could  not mount anything).

Not nice.

-- 
marko

