Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBMQRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBMQRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVBMQRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:17:12 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:64462 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261275AbVBMQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:17:09 -0500
Date: Sun, 13 Feb 2005 11:17:09 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andries Brouwer <aebr@win.tue.nl>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 access timings
Message-ID: <20050213161709.GA22287@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
	dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain> <20050127163431.GA31212@ti64.telemetry-investments.com> <20050127163714.GA15327@ucw.cz> <20050213001659.GA7349@ti64.telemetry-investments.com> <20050213082246.GC1535@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213082246.GC1535@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 09:22:46AM +0100, Vojtech Pavlik wrote:
> And I suppose it was running just fine without the patch as well?
 
Correct.

> The question was whether the patch helps, or whether it is not needed.
 
If you look again at the patch I posted, it only borrowed a few lines
of the patch from Dmitry that started this thread; I eliminated Alan's
recent udelay(50) addition, reduced the loop delay, and added debug
printks to the *_wait routines to determine whether the loop is ever taken.

At least so far, those debugging statements have produced no output.
I'll use the machine a bit and report back if I trigger anything.

Regards,

	Bill Rugolsky
