Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUAJUaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbUAJUaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:30:12 -0500
Received: from smtp4.hy.skanova.net ([195.67.199.133]:58365 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265445AbUAJUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:30:05 -0500
To: marcel@mesa.nl
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz>
	<200401101428.49358.dtor_core@ameritech.net>
	<20040110194040.GA24318@joshua.mesa.nl>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Jan 2004 21:29:59 +0100
In-Reply-To: <20040110194040.GA24318@joshua.mesa.nl>
Message-ID: <m24qv3sg1k.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcel J.E. Mol" <marcel@mesa.nl> writes:

> On Sat, Jan 10, 2004 at 02:28:49PM -0500, Dmitry Torokhov wrote:
> > On Saturday 10 January 2004 12:59 pm, Pavel Machek wrote:
> > > ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> > > is not really suitable to be enabled by default. You can not click by
> > > tapping the touchpad (well, unless you have very new X with right
> > > configuration, but than you can't go back to 2.4),
> > 
> > It is my understanding that by setting "Protocol" to "auto-dev" and
> > "Device" to "/dev/psaux" you can freely switch between 2.4 and 2.5.
> 
> I work with this setting for a couple of weeks now switching between 2.4
> and 2.6. The touchpad works quite well in X. (Dell inspiron 8000).
> I only notice I have to tap harder to get a click.

You can adjust the sensitivity by changing the FingerLow and
FingerHigh XFree86 driver parameters. They control how much finger
pressure is needed before it counts as a touch. (There are two
parameters to get a hysteresis effect.)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
