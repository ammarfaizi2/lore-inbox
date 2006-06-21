Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWFUJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWFUJWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWFUJWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:22:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:38074 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932493AbWFUJWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:22:07 -0400
To: hondaman <hondaman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trap divide error. X86_64, fc5, and 2.6.17
References: <44976CAA.8080000@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2006 11:22:05 +0200
In-Reply-To: <44976CAA.8080000@gmail.com>
Message-ID: <p738xnqq2wy.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hondaman <hondaman@gmail.com> writes:

> I compiled 2.6.17 under fc5.  Halfway through the boot, the screen is
> filled with this message:
> init[1] trap divide error rip:4296d7 rsp:7ffff792ed10 error:0
> I didnt change any of the default settings in the kernel.  Just
> unzipped, make menuconfig, save, make and installed it.

Maybe do a make distclean and try again? Sometimes kernels get miscompiled.
Also make sure old kernel still works.

-Andi
