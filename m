Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTDXAZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTDXAZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:25:44 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:2180 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264372AbTDXAZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:25:42 -0400
Date: Thu, 24 Apr 2003 10:37:58 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424003758.GD678@zip.com.au>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1592050000.1051142225@flay> <20030424002551.GA2980@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424002551.GA2980@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 02:25:52AM +0200, Pavel Machek wrote:
> If it is an *option*, it does not make code simpler.
> 
> And OOM-killing during suspend is just what you want. It makes suspend
> deterministic but it might kill someone. [Well, your solution would
> kill him sooner than that...]

I wouldn't say it's what you want. I really rather not have open office
(for eg) killed just because while I could have had the space to suspend
fully I wasn't able. And if it's my only reason for using the laptop at
the time then it just outright dieing might be just as useful.

Have the OOM killing if you want but being able to tack on an extra swap
partition when suspending would be most useful, either out of the kernel
or out of userspace, whichever would be the most reliable.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
