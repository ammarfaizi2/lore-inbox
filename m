Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265324AbTL0DEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTL0DEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:04:43 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:32775 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265324AbTL0DEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:04:42 -0500
Date: Sat, 27 Dec 2003 00:58:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: David Monro <davidm@amberdata.demon.co.uk>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: handling an oddball PS/2 keyboard (w/ patch)
Message-ID: <20031226235843.GA15973@win.tue.nl>
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl> <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk> <3FEAFDF3.80008@amberdata.demon.co.uk> <3FEB972B.4010406@amberdata.demon.co.uk> <20031226102210.GA11127@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226102210.GA11127@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 11:22:10AM +0100, Vojtech Pavlik wrote:

> This is intentional. Set 3 was never meant to be translated.

In fact it is just the opposite. Set 3 was designed to be translated.
Look at the translated codes:
Q (10), W (11), E (12), R (13), T (14), Y (15), U (16), I (17), O (18), P (19).
Completely regular.
Now look at the untranslated codes:
Q (15), W (1d), E (24), R (2d), T (2c), Y (35), U (3c), I (43), O (44), P (4d).
Messy.

Andries

