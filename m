Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVGFKy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVGFKy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVGFKvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:51:21 -0400
Received: from [203.171.93.254] ([203.171.93.254]:12190 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262215AbVGFIcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:32:20 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050706082230.GF1412@elf.ucw.cz>
References: <11206164393426@foobar.com>  <20050706082230.GF1412@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120638824.4860.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 18:33:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 18:22, Pavel Machek wrote:
> Hi!
> 
> > As requested, here are the patches that form Suspend2, for review.
> > 
> > I've tried to split it up into byte size chunks, but please don't expect
> > that these will be patches that can mutate swsusp into Suspend2. That
> > would roughly equivalent to asking for patches that patch Reiser3 into
> > Reiser4 - it's a redesign.
> > 
> > There are a few extra patches not included here, all of which are not
> > core to Suspend2. Since I'm not expecting this code to get merged as is,
> > I haven't worried about including them. If that's a problem, let me know.
> 
> Is swsusp1 expected to be functional after these are applied? You
> removed *some* of its hooks, but not all, so I'm confused.

It should definitely still be functional.

In the past I've gone with the logic that if people go to the trouble of
patching suspend2 in, they probably want to use it instead of swsusp.
I'm happy for the reboot and acpi patches to be left out for now.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

