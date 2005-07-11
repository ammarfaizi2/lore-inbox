Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVGKJgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVGKJgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGKJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:36:49 -0400
Received: from [203.171.93.254] ([203.171.93.254]:14809 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261470AbVGKJgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:36:48 -0400
Subject: Re: [PATCH] [29/48] Suspend2 2.1.9.8 for 2.6.12:
	606-all-settings.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710180351.GC10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164424113@foobar.com>
	 <20050710180351.GC10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121074710.7502.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 11 Jul 2005 19:38:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:03, Pavel Machek wrote:
> Hi!
> 
> > +static void suspend2_suspend_2(void)
> > +{
> > +	if (!save_image_part1()) {
> > +		suspend_power_down();
> > +
> > +		if (suspend2_powerdown_method == 3) {
> > +			int temp_result;
> > +
> > +			temp_result = read_pageset2(1);
> 
> 
> Is that just me or do I see way too many numbers. suspend2_suspend_2
> is really funny name for a functions. powerdown_method should really
> use some symbolic constants.

No, it's not just you. It's one of those hangovers from the original
code that I hadn't gotten around to cleaning up.

Symbolic constants now in place for the powerdown method too.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

