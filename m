Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTFRWEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTFRWEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:04:52 -0400
Received: from ns.suse.de ([213.95.15.193]:35089 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265563AbTFRWEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:04:51 -0400
Date: Thu, 19 Jun 2003 00:18:49 +0200
From: Andi Kleen <ak@suse.de>
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, David Mosberger <davidm@napali.hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: add /proc/sys/kernel/cache_decay_ticks
Message-ID: <20030618221849.GD3543@wotan.suse.de>
References: <200306182151.h5ILpMcx022062@napali.hpl.hp.com.suse.lists.linux.kernel> <p73znkf2g9t.fsf@oldwotan.suse.de> <16112.58330.522570.329438@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16112.58330.522570.329438@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see why the two have to be tied together.  I agree it would be
> _nice_, but having /proc/sys/kernel/cache_decay_ticks in it's current
> form is much better than nothing at all.

The problem is that when you change it later with the sysctl you have a subtle
user visible change, breaking existing users.

-Andi

