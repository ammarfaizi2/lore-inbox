Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWJBJqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWJBJqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWJBJqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:46:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:16850 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWJBJqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:46:30 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISDN: mark as 32-bit only
References: <20061001152116.GA4684@havoc.gtf.org>
From: Andi Kleen <ak@suse.de>
Date: 02 Oct 2006 11:46:27 +0200
In-Reply-To: <20061001152116.GA4684@havoc.gtf.org>
Message-ID: <p73bqovhwy4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
> won't work on 64-bit.

Actually AFAIK all ISDN drivers work on x86-64.
However x86-64 doesn't support all of them because many depend
on CONFIG_ISA.

-Andi
