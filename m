Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263179AbVCJWGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbVCJWGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVCJWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:03:49 -0500
Received: from [220.233.7.36] ([220.233.7.36]:42137 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263217AbVCJVxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:53:30 -0500
Date: Fri, 11 Mar 2005 08:52:01 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ITE8212
Message-ID: <20050310215201.GA14146@zip.com.au>
References: <20050310122824.GX1811@zip.com.au> <1110466294.28860.287.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110466294.28860.287.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 02:51:35PM +0000, Alan Cox wrote:
> On Iau, 2005-03-10 at 12:28, CaT wrote:
> > hda: max request size: 128KiB
> > hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG
> > hda: cache flushes not supported
> >  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: recal_intr: error=0x04 { DriveStatusError }
> 
> Ooh great stuff, definitely want to know more. A couple of folks report
> that and mine won't do it.

I've got another one of these cards and it does not display these
issues. That box is running 2.6.9-ac10 whilst mine is running 2.6.11-ac2
though and the HD is a western digital whilst my HDs are a Seagate and an
IBM. I can't really test on that box (but I can give out any 'doesn't
require me to poke it hard' info) as it's in production but my g/w is
fine for testing stuff.

Should I be worried about the BUG bit on the hda and hdc lines as above?

> Ok its correctly trimmed the modes, but not it seems the current mode.
> I'll send you a tweak to avoid multisect being played with.

Cool. BTW I set multisec manually and flipped unmaskirq on and did a
copy of 37GB of data from hdc to hda. The promise card used to fail
abysmally at this task (either with both drives on the one card or (and
this was worse) one drive per card). This fills me with more joy then I
can say. I've been wanting to make this box my mail server for yonks and
now it looks like I'll be able to. Thanks! :)

/dev/hdc2             39411702  37471662         0 100% /data/share
/dev/hda1            192292124  37610568 144913636  21% /mnt

*dance*

-- 
    Red herrings strewn hither and yon.
