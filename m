Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTIPVXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTIPVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:23:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:2564 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262526AbTIPVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:23:22 -0400
Date: Tue, 16 Sep 2003 23:23:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030916232318.A1699@pclin040.win.tue.nl>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Fri, Sep 12, 2003 at 01:45:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 01:45:14PM -0400, Zwane Mwaikambo wrote:

> 	I have the same problem with an Avocent SwitchView and Keytronic 
> keyboard, although it doesn't sound as bad as your problem. Occasionally 
> some keys just repeat until i press another key.

In Petr's case it looks like his switch produces a single well-defined
byte (0x41) when switching. What about you? Do you get garbage at the
moment of switching, or always the same code(s)?
Do you only get the spurious repeat when switching?
Andrew gets spurious repeats together with mouse activity. Do you?

I am especially interested in cases where people can reproduce
an unwanted key repeat. The question is: is this a bug in our timer code
or use of timers, or did the keyboard never send the key release code?

(#define DEBUG in i8042.c)

Andries

