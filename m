Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUKDBjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUKDBjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUKDBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:39:04 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:35486 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262035AbUKDBjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:39:01 -0500
To: Russell Miller <rmiller@duskglow.com>
Cc: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031540.03598.gene.heskett@verizon.net>
	<20041104004342.GD5283@kurtwerks.com>
	<200411031901.28977.rmiller@duskglow.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 03 Nov 2004 20:38:48 -0500
In-Reply-To: <200411031901.28977.rmiller@duskglow.com> (Russell Miller's
 message of "Wed, 3 Nov 2004 20:01:28 -0500")
Message-ID: <87654m4clz.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> writes:

> This brings up another question I've had since reading the documentation on 
> later pentium-class chips:
>
> why are only rings 0 and 3 used in linux?

Because the "traditional" Unix privilege model only has two levels,
and Linux runs on many architectures, most of which have only two
privilege levels (the 68000 called them "user" and "supervisor").
Special-casing x86 is possible but probably wouldn't be worth it.

-Doug
