Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbTJVPYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTJVPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:24:23 -0400
Received: from virt-216-40-198-21.ev1servers.net ([216.40.198.21]:31499 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S263425AbTJVPYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 11:24:07 -0400
Date: Wed, 22 Oct 2003 10:17:43 -0500
From: Chuck Campbell <campbell@accelinc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031022151743.GA21348@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	linux-kernel@vger.kernel.org
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net> <bn48t7$j8s$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bn48t7$j8s$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 09:36:39PM +0000, bill davidsen wrote:
> In article <yw1xu167kbcw.fsf@users.sourceforge.net>,
> =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net> wrote:
> | Bill Davidsen <davidsen@tmr.com> writes:
> 
> Unfortunately my experience is with either the cheap motherboard ones I
> get for free and the IBM ServRAID controllers which are kind of in the
> "more than that" category. The benefit of the m/b ones is that with
> RAID-1 you will get a boot if the boot drive fails. Period. Unlike
> optimal RAID-1 which will read mirrored data from any non-busy drive,
> the cheap ones seem to do fail-over only, and read the second drive
> only if the first fails, or even require both drives to be on the same
> cable, ensuring that the bus will be busy when either drive is busy.
> They do buy reliability, however, so there are places where they are
> very cost effective.

In this situation that you describe, how does one recover from this?  Do 
these cheap motherboard RAID-1's do an autorebuild when the failed
disk is replaced?  (Obviously not hot-swap, but on reboot to replace
the drive).

> 
> The IBM controllers are everything you ever wanted in a controller. It
> supports four SCSI busses for bandwidth, all the RAID types including
> 5e, and it has Linux config software so you can do most reconfigures on
> a running system. I would choose them over anything else I've personally
> used, mainly Adaptec and PERC. They are really great for multi-TB
> storage systems.

Do they compare favorable against 3Ware as well?

> Anyone who says that any one solution is best for everything is clearly
> misguided, but I do think that for many midsize applications that
> software RAID is the most cost effective solution, and vs. moderately
> priced controllers very likely to be the higher performance solution as
> well.

Is this statement true, in your opinion, for RAID-5 as well?

-chuck

-- 
