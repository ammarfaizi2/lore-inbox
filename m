Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVKMDal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVKMDal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKMDal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:30:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:33427 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751259AbVKMDal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:30:41 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
References: <7.282480653@selenic.com> <8.282480653@selenic.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 04:30:35 +0100
In-Reply-To: <8.282480653@selenic.com>
Message-ID: <p738xvt442s.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> This adds configurable support for doublefault reporting on x86

I think that's a bad idea. Users will disable it and then 
send bad bug reports. Better bug reports are worth 4K.

-Andi
