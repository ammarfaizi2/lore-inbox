Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274935AbTHISi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275231AbTHISi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 14:38:56 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19471 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S274935AbTHISiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 14:38:55 -0400
Date: Sat, 9 Aug 2003 20:38:52 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3 and earlier] no keyboard
Message-ID: <20030809203852.A9000@pclin040.win.tue.nl>
References: <87ptjebwb8.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87ptjebwb8.fsf@deneb.enyo.de>; from fw@deneb.enyo.de on Sat, Aug 09, 2003 at 07:00:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 07:00:27PM +0200, Florian Weimer wrote:

> 2.6.0-test3 and earlier provide only a very limited form of console on
> a Siemens Primergy H450.
> 
> For example, pressing RET yields:
> 
> atkbd.c: Unknown key (set 0, scancode 0xed, on isa0060/serio0) pressed.          
> 
> So far, I only tested remotedly, using the built-in console
> redirection support.  2.4.20 works like a charm (using remote console,
> I think we never tested the local one).

Set 0 is "impossible", certainly a bug.
So what are the boot messages about the keyboard?




