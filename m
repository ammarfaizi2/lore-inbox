Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270516AbTGVVSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270539AbTGVVSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:18:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21521
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270516AbTGVVSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:18:22 -0400
Date: Tue, 22 Jul 2003 14:33:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030722213326.GB1176@matchmail.com>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030722013443.GA18184@netnation.com> <20030722172858.GB2880@home.woodlands> <1058899713.733.6.camel@teapot.felipe-alfaro.com> <20030722203716.GA1321@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722203716.GA1321@home.woodlands>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 02:07:16AM +0530, Apurva Mehta wrote:
> * Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> [2003-07-23 00:30]:
> > On Tue, 2003-07-22 at 19:28, Apurva Mehta wrote:
> > > I usually run Opera and the skipping occurs often while switching
> > > between tabs with the mouse (not when it is done with the keyboard).
> > > 
> > > Also, severe xmms skipping occurs while scrolling through PDF files
> > > (in Acrobat) while the first few seconds of a song are playing. The
> > > song virtually stops while I scroll. After the song plays for a bit,
> > > scrolling through a PDF makes no difference.
> > > 
> > > Sometimes, xmms pops up in between songs saying that it could not
> > > detect the audio device! This occurs mainly during heavy disk i/o or
> > > cpu usage.
> > 
> > Could you please test 2.6.0-test1-mm2 instead? It has additional
> > scheduler fixes which should improve your overall experience.
> 
> I just patched my tree and compiled it. It does not work.. It freezes
> the system when I try to start X.. I gives a huge error message and
> the last line is something like :
> <6>note: X[1306] exited with preempt_count 1
> 
> I checked all the logs and I cannot find the complete error message
> anywhere. Any suggestions where to look? 

How about your Xfree86 log?  (probably somewhere in /var/log)
