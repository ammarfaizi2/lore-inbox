Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDWVPB>; Mon, 23 Apr 2001 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132045AbRDWVOo>; Mon, 23 Apr 2001 17:14:44 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:10072 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131990AbRDWVNJ>;
	Mon, 23 Apr 2001 17:13:09 -0400
Message-ID: <20010423231312.A18870@win.tue.nl>
Date: Mon, 23 Apr 2001 23:13:12 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3-Ware Raid driver fails to update GenDisk head
In-Reply-To: <20010423120852.A32097@vger.timpanogas.org> <20010423214701.A18855@win.tue.nl> <20010423135500.B32378@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010423135500.B32378@vger.timpanogas.org>; from Jeff V. Merkey on Mon, Apr 23, 2001 at 01:55:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 01:55:00PM -0600, Jeff V. Merkey wrote:
> On Mon, Apr 23, 2001 at 09:47:01PM +0200, Guest section DW wrote:
> > On Mon, Apr 23, 2001 at 12:08:52PM -0600, Jeff V. Merkey wrote:
> > > 
> > > I am still working on this, but would appreciate some help from
> > > whomever owns this driver proper.  I have discovered that the 
> > > 3Ware drivers are not updating the gendisk_head with devices
> > > reported and exposed to user space as /dev/sda, sdb, etc.
> > 
> > But that is the job of sd.c, not of a driver.
> 
> These drivers are an IDE driver that simulates a SCSI interface.  It 
> reported IDE devices as SCSI handles, so there's some holes.  I guess
> you were not aware of this, or you would have known that standard sd.c
> is not working.

Just like ide-scsi.c you mean?
