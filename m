Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131821AbRBDPSc>; Sun, 4 Feb 2001 10:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRBDPSX>; Sun, 4 Feb 2001 10:18:23 -0500
Received: from [203.169.151.222] ([203.169.151.222]:51467 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S131821AbRBDPSJ>;
	Sun, 4 Feb 2001 10:18:09 -0500
Message-ID: <3A7D72BB.32D44334@coppice.org>
Date: Sun, 04 Feb 2001 23:18:19 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102040756120.5276-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Trausch" wrote:
> 
> On Sat, 3 Feb 2001, Josh Myer wrote:
> 
> > Hello all,
> >
> > I know this _really_ isn't the forum for this, but a friend of mine has
> > noticed major, persistent clock drift over time. After several weeks, the
> > clock is several minutes slow (always slow). Any thoughts on the
> > cause? (Google didn't show up anything worthwhile in the first couple of
> > pages, so i gave up).
> >
> 
> I'm having the same problem here.  AMD K6-II, 450 MHz, VIA Chipset, Kernel
> 2.4.1.

If you don't use software time correction a minute a week is not too
bad, by current PC standards. Most Compaqs are off by more like a minute
a day. I have verified with a frequency counter that it is actually the
Compaq crystal oscillator which is at fault. Most motherboards are
better than this, but many are not great. The battery backed CMOS clock
is usually a lot better than the interrupt based one, but still not
great. They don't tweak them up like a watch maker would, even though
they usually use the same type of crystal.

Regards,
Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
