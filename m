Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310455AbSCHSC0>; Fri, 8 Mar 2002 13:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSCHSCQ>; Fri, 8 Mar 2002 13:02:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11768
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310455AbSCHSCK>; Fri, 8 Mar 2002 13:02:10 -0500
Date: Fri, 8 Mar 2002 10:02:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Boszormenyi Zoltan <zboszor@mail.externet.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Ext2/Ext3 partition label abuse
Message-ID: <20020308180257.GG28141@matchmail.com>
Mail-Followup-To: Guest section DW <dwguest@win.tue.nl>,
	Boszormenyi Zoltan <zboszor@mail.externet.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C88890C.6010303@mail.externet.hu> <20020308143345.GA13406@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308143345.GA13406@win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 03:33:45PM +0100, Guest section DW wrote:
> On Fri, Mar 08, 2002 at 10:49:00AM +0100, Boszormenyi Zoltan wrote:
> 
> [I had two disks with the same labels on one machine and that caused
> problems with booting]
> 
> Yes, if you have an fstab file that says: mount the filesystem with
> label "ROOTDISK" on /, and then come with two filesystems that both are
> labeled "ROOTDISK", then it is hardly surprising when problems arise.
> The same will happen if you use UUID instead of label but created the
> other disk by copying the first using dd.
> 
> You can change fstab for example with an editor.
> You can change labels for example with the e2label utility.
> 
> Labels have an advantage for example when you add or remove a SCSI disk:
> the label stays the same but the disks are renumbered.
> Also when you add or remove partitions, causing a renumbering.
> Using UUID is slightly more stable, slightly less user-friendly.
> 
> Attaching a significance to the order of items in /proc/partitions
> is a bad idea.

It would be nice if the raid code could do that with drive serial numbers...
