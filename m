Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292195AbSBYTZA>; Mon, 25 Feb 2002 14:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSBYTYt>; Mon, 25 Feb 2002 14:24:49 -0500
Received: from a213-22-82-74.netcabo.pt ([213.22.82.74]:4874 "EHLO
	skyblade.homeip.net") by vger.kernel.org with ESMTP
	id <S292195AbSBYTYe>; Mon, 25 Feb 2002 14:24:34 -0500
Date: Mon, 25 Feb 2002 19:24:23 +0000 (WET)
From: =?iso-8859-15?Q?Jos=E9_Carlos_Monteiro?= <jcm@skyblade.homeip.net>
To: John Alvord <jalvo@mbay.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Emu10k1 SPDIF passthru doesn't work if CONFIG_NOHIGHMEM is not
 enabled
Message-ID: <Pine.LNX.4.33.0202251918520.5719-100000@skyblade.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Seg, 2002-02-25 at 18:16, John Alvord wrote:
> I know it is again more work, but the next usual step is to determine
> the differences between the two pre levels and add them in one at a
> time to the working pre level until the function break occurs.

Ok, but I think that may be a little bit out of my league. I mean, I'd
like to help, but where am I supposed to find all the individual patches?
Is is possible to break the pre1-pre2 patch file into individual files?

Or, is there a repository for that sort of thing? Or if someone emailed me
all the 7 patches in individual files, I could test them one by one.


Regards
Zé


> On Sun, 24 Feb 2002 22:28:34 +0000 (WET), I wrote:
> >> Emu10k1 SPDIF passthru with the creative/kernel OSS driver only works
> >> if the kernel option CONFIG_NOHIGHMEM is set. If one of the other two
> >> related options (CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G) is used
> >> instead, the sound card is unable to "pass" AC3 streams "through" the
> >> SPDIF output; only PCM and multi-channel sound gets out.
> >
> >I tested all the pre-patches between kernels 2.4.12 and 2.4.13
> >and I found that kernel 2.4.13-pre2 was the one that broke it.
> >2.4.13-pre2:
> >- Alan Cox: more merging
> >- Ben Fennema: UDF module license
> >- Jeff Mahoney: reiserfs endian safeness
> >- Chris Mason: reiserfs O_SYNC/fsync performance improvements
> >- Jean Tourrilhes: wireless extension update
> >- Joerg Reuter: AX.25 updates
> >- David Miller: 64-bit DMA interfaces


