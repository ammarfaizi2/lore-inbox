Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTHCKkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTHCKkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:40:13 -0400
Received: from ppp-62-245-209-155.mnet-online.de ([62.245.209.155]:19845 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S271384AbTHCKkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:40:10 -0400
To: Timothy Miller <miller@techsource.com>
Subject: Re: Turning off automatic screen clanking
Cc: linux-kernel@vger.kernel.org
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sun, 03 Aug 2003 12:40:08 +0200
In-Reply-To: <frB6.8gE.7@gated-at.bofh.it> (Timothy Miller's message of
 "Thu, 31 Jul 2003 21:50:08 +0200")
Message-ID: <frodoid.frodo.87brv7t46v.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <eFZJ.6X7.29@gated-at.bofh.it> <eH5i.7XC.15@gated-at.bofh.it>
	<eNaA.4vE.1@gated-at.bofh.it> <eRHk.85K.5@gated-at.bofh.it>
	<fmBF.48z.41@gated-at.bofh.it> <fotH.5J2.17@gated-at.bofh.it>
	<frB6.8gE.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

Hello Timothy,

> So, if there's no point to having screen-blanking, why is it in there
> to begin with?  To protect OLD monitors from burnin?

> Is screen-blanking there just to make people feel better who think
> they need screen-blanking?  As I understand, it doesn't do any
> power-management stuff anyhow.

My monitor (Iiyama Vision Master Pro 21) turns its power off as soon
as it realizes that the screen was staying black for a certain amount
of time (configurable). It hasn't anything to do with power management
stuff, since I can also reproduce it by turning the cursor off and
then typing "clear; sleep 10000000" in my shell.

That's why I appreciate the kernel console blanking.

Although I suppose it would do the same if you just cycle the colors,
since the monitor shouldn't notice the difference. But you would have
to cycle the colors to black, I guess. "very dark grey" would probably
not be enough.

And then I see no point in cycling the colors instead of blanking.

Julien
