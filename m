Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRBKCjx>; Sat, 10 Feb 2001 21:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131804AbRBKCjn>; Sat, 10 Feb 2001 21:39:43 -0500
Received: from unthought.net ([212.97.129.24]:52889 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131795AbRBKCjf>;
	Sat, 10 Feb 2001 21:39:35 -0500
Date: Sun, 11 Feb 2001 03:39:34 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION]: IDE Driver support for S.M.A.R.T?
Message-ID: <20010211033934.A6012@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Shawn Starr <Shawn.Starr@Home.net>,
	lkm <linux-kernel@vger.kernel.org>
In-Reply-To: <3A85F698.5DCB3F1E@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3A85F698.5DCB3F1E@Home.net>; from Shawn.Starr@Home.net on Sat, Feb 10, 2001 at 09:19:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2001 at 09:19:05PM -0500, Shawn Starr wrote:
> Does the current (E)IDE driver support SMART?

Yes.

[eagle:joe] $ ls /proc/ide/hda/smart_*
 /proc/ide/hda/smart_thresholds
 /proc/ide/hda/smart_values

> 
> Will Linux report any S.M.A.R.T errors or warnings to the system log?

No.

You can set that up yourself with a script that compares the smart_thresholds
with the smart_values.

The values and thresholds are vendor/model/moonphase-specific,
so there's not really any way the kernel can make much sense out of them.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
