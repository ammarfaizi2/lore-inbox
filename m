Return-Path: <linux-kernel-owner+w=401wt.eu-S964868AbWLTEyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWLTEyJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWLTEyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:54:09 -0500
Received: from ozlabs.org ([203.10.76.45]:33361 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964885AbWLTEyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:54:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17800.46811.966114.640221@cargo.ozlabs.ibm.com>
Date: Wed, 20 Dec 2006 15:06:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: use is_init()
In-Reply-To: <20061219083549.GA4025@APFDCB5C>
References: <20061219083549.GA4025@APFDCB5C>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita writes:

> Use is_init() rather than hard coded pid comparison.

What's the context of this patch?  Why is this a good thing to do?

Doing a git grep -w is_init on Linus' current git tree reveals an
is_init() in arch/parisc/kernel/module.c, which looks to be something
different, but no generic definition of an is_init() function or
macro.

Paul.
