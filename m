Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270960AbTGPQ44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270961AbTGPQzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:55:55 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:58257 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270957AbTGPQy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:54:58 -0400
Date: Wed, 16 Jul 2003 18:09:11 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: vojtech@suse.cz, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716170911.GB21896@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, vojtech@suse.cz,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716170352.GJ833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:03:52PM +0200, Jens Axboe wrote:

 > > It only happens whilst cdparanoia is reading from the CD.
 > > The IDE CD drive is using DMA, and interrupts are unmasked.
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > Yes. You can try and make the situation a little better by unmasking
 > interrupts with -u1.

See above 8-) It was the first thing I tried when I observed this phenomenon.

 > Or you can try and use a ripper that actually uses
 > SG_IO, that way you can use dma (and zero copy) for the rips. That will
 > be lots more smooth.

Ah right, I thought cdparanoia was still ripper de jour..
What's recommended these days?

		Dave

