Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWHHJPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWHHJPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWHHJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:15:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:51107 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWHHJPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:15:51 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: mark two more functions as __init
References: <20060808081756.334.46571.sendpatchset@cherry.local>
From: Andi Kleen <ak@suse.de>
Date: 08 Aug 2006 11:15:44 +0200
In-Reply-To: <20060808081756.334.46571.sendpatchset@cherry.local>
Message-ID: <p73fyg7pozj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> i386: mark two more functions as __init
> 
> cyrix_identify() should be __init because transmeta_identify() is.
> tsc_init() is only called from setup_arch() which is marked as __init.
> 
> These two section mismatches have been detected using running modpost on
> a vmlinux image compiled with CONFIG_RELOCATABLE=y.

I queued both patches (topology and this one) 

-Andi
