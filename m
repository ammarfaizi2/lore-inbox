Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVEaUlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVEaUlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVEaUlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:41:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:22660 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261447AbVEaUlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:41:21 -0400
X-Authenticated: #4399952
Date: Tue, 31 May 2005 22:41:16 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steve Finney <saf76@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: Human tIming perception (was: RT patch)
Message-ID: <20050531224116.7049eb18@mango.fruits.de>
In-Reply-To: <1117569835.23283.24.camel@mindpipe>
References: <10471395.1117558743885.JavaMail.root@wamui-milano.atl.sa.earthlink.net>
	<1117569835.23283.24.camel@mindpipe>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 16:03:55 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2005-05-31 at 12:59 -0400, Steve Finney wrote:
> > It takes (IIRC) about a 10 ms or 
> > so difference in the sounded sequence
> > for someone to be able to report that there's been a change, but
> > a cnange in the timing of the person's finger movements occurs
> > (_immediately_) at perturbations smaller than 10 ms. That is, there 
> > appears to be some dissociation  between conscious perception and 
> > perceptual/motor behavior.
> 
> Any decent guitar player who has used their computer as an effects unit
> could tell you this.  I can easily perceive the difference between 1.3
> and 2.6, and 2.6 and 5ms latencies.  And there's at least one person
> (also a guitarist, who I have added to the cc:) who swears he cam
> perceive the difference between 0.6 and 1.3ms.  Soundcard ADCs typically
> add 1.5ms latency in each direction, so the actual floor seems to be
> around 3-5ms.

Hi,

hmm, there must be a misunderstanding here. I did have a soundcard of
which the DA/AD's added another (ca.) 5 ms of latency to the systematic
latency (1.3 ms roundtrip with 32 frames per period at 48khz
samplerate). I could hear the difference between using a periodsize of
64 frames to a periodsize of 32 frames with that card.. 32 frames/period
gave me a total latency of around 6.3 ms. 64 frames/per period resulted
in a total roundtrip latency of 7.7 ms. I could hear that difference. 32
was very well usable, 64 wasn't. It seems my personal borderline for
perceiving "zero latency" was somewhere between 6.3 and 7.7 ms..

Maybe my original post was badly worded. Hope to have cleared it up
(also i'm not sure on the exact value of the additional latency the
AD/DA's introduced. Might also have been 4 or 6 ms.. Something in that
range though)..

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/
