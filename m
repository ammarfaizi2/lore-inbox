Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUBEI26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 03:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUBEI26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 03:28:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55310 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264361AbUBEI2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 03:28:55 -0500
Date: Thu, 5 Feb 2004 08:28:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steve Kenton <skenton@ou.edu>
Cc: rth@twiddle.net, spyro@f2s.com, bjornw@axis.com,
       ysato@users.sourceforge.jp, Linux Kernel <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
       paulus@samba.org, schwidefsky@de.ibm.com, gniibe@m17n.org,
       wesolows@foobazco.org, davem@redhat.com, jdike@karaya.com,
       uclinux-v850@lsi.nec.co.jp, ak@suse.de
Subject: Re: 2.6.2 make defconfig for all arches give 171 "trying to assign nonexistent symbol" errors
Message-ID: <20040205082828.A4252@flint.arm.linux.org.uk>
Mail-Followup-To: Steve Kenton <skenton@ou.edu>, rth@twiddle.net,
	spyro@f2s.com, bjornw@axis.com, ysato@users.sourceforge.jp,
	Linux Kernel <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com,
	jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
	paulus@samba.org, schwidefsky@de.ibm.com, gniibe@m17n.org,
	wesolows@foobazco.org, davem@redhat.com, jdike@karaya.com,
	uclinux-v850@lsi.nec.co.jp, ak@suse.de
References: <40216DEE.6040306@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40216DEE.6040306@ou.edu>; from skenton@ou.edu on Wed, Feb 04, 2004 at 04:10:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 04:10:54PM -0600, Steve Kenton wrote:
> 2.6.2 make defconfig for all arches give 171 "trying to assign nonexistent symbol" errors
> total in 13 different arches, up from 143 in 2.6.1.
> 
> arm		37

The standard ARM defconfig is next to useless anyway - most if not all
people will choose one of the other defconfig files in arch/arm/configs
first.

If someone wants to maintain the 46 ARM defconfigs, that's fine by me.
However, traditionally this has ended up producing stupidly massive
patches.

(I'm not saying its a bad thing - I'm just pointing out that keeping
them up to date will be a large job for someone.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
