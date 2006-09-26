Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWIZO3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWIZO3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWIZO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:29:43 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:16648 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751512AbWIZO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:29:42 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dominique Dumont <domi.dumont@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-user <alsa-user@lists.sourceforge.net>
Subject: Re: Pb with simultaneous SATA and ALSA I/O
X-URL: <http://www.mandrivalinux.com/
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<20060925143838.GQ13641@csclub.uwaterloo.ca>
	<1159195859.2899.72.camel@mindpipe>
From: Thierry Vignaud <tvignaud@mandriva.com>
Organization: Mandriva
Date: Tue, 26 Sep 2006 16:29:39 +0200
In-Reply-To: <1159195859.2899.72.camel@mindpipe> (Lee Revell's message of "Mon, 25 Sep 2006 10:50:59 -0400")
Message-ID: <m24puu7lbg.fsf@vador.mandriva.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> > Well i agree with the suggestion of trying a different PCI slot
> > for the sb live.  There is so much onboard stuff sharing
> > interrupts on those boards that you might have problems because of
> > that.  Creative cards are not very good at dealing with anything
> > other than ideal conditions from what I have gathered over the
> > years.  The manual for the board will tell you which IRQ goes to
> > which slot, and I guess you want to avoid using a slot that shares
> > with the SATA controller.
> 
> It might not be interrupt related, it could be DMA starvation.  This
> has been observed with some SATA controllers while testing the -rt
> patches.  The symptom is that the latency traces show the machine
> going in "slow motion".

with the -rt patch, high resolution timer + dyn helps too in going in
deep slow mode.
