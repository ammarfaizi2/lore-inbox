Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTGOWKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbTGOWKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:10:11 -0400
Received: from maild.telia.com ([194.22.190.101]:28618 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S269623AbTGOWJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:09:59 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Dax Kelson <dax@gurulabs.com>
Cc: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
References: <200307151244.53276.gallir@uib.es>
	<1058296451.2394.63.camel@mentor.gurulabs.com>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2003 23:27:22 +0200
In-Reply-To: <1058296451.2394.63.camel@mentor.gurulabs.com>
Message-ID: <m2fzl7h45h.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> writes:

> On Tue, 2003-07-15 at 04:44, Ricardo Galli wrote:
> > The new synaptics driver doesn't work with Dell Latitude Touchpad, it doesn't 
> > work any /dev/input/event?|mouse? and /dev/psaux neither (altough the same 
> > configuration worked at least until 2.5.70).
> 
> I can replicate this problem with 2.6.0-test1 on a Dell Inspiron 4150
> laptop as well.
> 
> Synaptics Touchpad, model: 1
>  Firware: 5.9
>  180 degree mounted touchpad
>  Sensor: 27
>  new absolute packet format
>  Touchpad has extended capability bits
>  -> multifinger detection
>  -> palm detection
> input: Synaptics Synaptics TouchPad on isa0060/serio1

This doesn't look like the same problem. There is no "reset failed"
message. Are you using the correct XFree86 driver:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

Also, note that the driver doesn't work with gpm yet.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
