Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbSKFAZI>; Tue, 5 Nov 2002 19:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKFAZI>; Tue, 5 Nov 2002 19:25:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25069 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265445AbSKFAZG>;
	Tue, 5 Nov 2002 19:25:06 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [Evms-announce] EVMS announcement
To: Mike Diehl <mdiehl@dominion.dyndns.org>
Cc: "Kevin M Corry" <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFCC91E1D2.FC7FCB3C-ON05256C69.0001DCF6@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Tue, 5 Nov 2002 19:55:07 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and RM_DEBUG |October 24, 2002) at 11/05/2002 07:31:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Diehl wrote:
>Well, I'm a bit disapointed.  My experience with LVM has been nothing
>short of disasterous; EVMS looked like a very good alternative to LVM.
>Volume Management is one of the FEW things that Linux lacks that the
>"Big Boys" have.

>The biggest thing that EVMS had going for it was it's modular design.  As
I
>understand it, EVMS could even be used to manage the current MD and LVM
>drivers.  I was looking forward to partition-level encryption, etc.

Let me take a minute to reiterate: EVMS is not going away and has not
given up on any of it's original goals.  EVMS will still use a plug-in
architecture in the user space tools (Engine) to coordinate across
different types of kernel volume management drivers.  You will still
be able to use EVMS to partitions disks, create MD RAID arrays,
add these arrays to LVM containers, create regions and volumes and
mkfs your filesystems and a whole lot more, all from the EVMS
interface you know and love.


>I wish the decision had gone the other way.  Get rid of LVM and get EVMS
into
>the mainstream.  Any chance that, after this "migration," we might do just
>that?

Could happen, but don't hold your breath.

>I'd love to see the day when LVM and MD aren't kernel options by
>themselves, but rather options under EVMS, along with lots of other cools
>things.

Sure, why not.  EVMS can manage both and can be expanded to manage other
device types as well.

>But never mind me.  I'm just a linux user, not a linux developer.

But users matter!!!  If we get the migration right (and we will) the only
thing
you will notice different with EVMS are the kernel config options and the
ramdisk /ramfs stuff.  Everything else should look and fell and work
exactly
the same from a user's point of view.

Steve




