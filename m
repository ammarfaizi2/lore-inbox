Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUE1T7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUE1T7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUE1T7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:59:42 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:14341 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263876AbUE1T5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:57:13 -0400
Date: Fri, 28 May 2004 21:57:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Chris Osicki <osk@osk.ch>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040528195709.GB5175@pclin040.win.tue.nl>
References: <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sau Dan Lee wrote:

> Actually, I have a side issue with input/i8042 related things: The
> keyboard on my laptop worked slightly different: On 2.4.*, SysRq is
> activated using a [Fn] key-combo, which agrees with the keycap labels
> on the laptop keyboard. After upgrading to 2.6, that key-combo no
> longer works. Instead, I must use Alt-PrintScreen as the key for
> SysRq. (And unfortunately, PrintScreen is a [Fn] combo on the laptop,
> thus requiring press 3 keys at the same time for SysRq, and a fourth
> key to use the various SysRq features. Very inconvenient.) Is this
> again due to some dirty translation processes down in the input layer?
> Is the input layer always assuming that Alt-PrintScreen == SysRq?
> This is not always true. Can the input layer be so configured that it
> never tries to interpret the scancodes, but pass them to the upper
> layers?

So, what scancodes do you get in 2.4? And in 2.6? (Use scancode -s.)

Andries

