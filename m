Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270990AbTGVSdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTGVSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:33:33 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52487 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270990AbTGVSdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:33:31 -0400
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Apurva Mehta <apurva@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030722172858.GB2880@home.woodlands>
References: <20030722013443.GA18184@netnation.com>
	 <20030722172858.GB2880@home.woodlands>
Content-Type: text/plain
Message-Id: <1058899713.733.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 20:48:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-22 at 19:28, Apurva Mehta wrote:
> * Simon Kirby <sim@netnation.com> [2003-07-22 11:50]:
> > I keep seeing cases where browsing in mozilla / galeon will suck away all
> > CPU from X updating the mouse, xmms playing, etc., for about a second as
> > Mozilla renders a page (which should take 50 ms to render, but anyway..).
> 
> I do not have any problems with mouse response, but xmms sure does
> skip a whole lot more on my 2.6.0-test1 running on a PIII 500 MHz, 192
> MB RAM. 
> 
> I usually run Opera and the skipping occurs often while switching
> between tabs with the mouse (not when it is done with the keyboard).
> 
> Also, severe xmms skipping occurs while scrolling through PDF files
> (in Acrobat) while the first few seconds of a song are playing. The
> song virtually stops while I scroll. After the song plays for a bit,
> scrolling through a PDF makes no difference.
> 
> Sometimes, xmms pops up in between songs saying that it could not
> detect the audio device! This occurs mainly during heavy disk i/o or
> cpu usage.

Could you please test 2.6.0-test1-mm2 instead? It has additional
scheduler fixes which should improve your overall experience.

Thanks!

