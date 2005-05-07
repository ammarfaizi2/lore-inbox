Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVEGCgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVEGCgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 22:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVEGCgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 22:36:14 -0400
Received: from ozlabs.org ([203.10.76.45]:17336 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261522AbVEGCgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 22:36:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17020.10671.866725.569831@cargo.ozlabs.ibm.com>
Date: Sat, 7 May 2005 12:36:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerrit Huizenga <gh@us.ibm.com>, sharada@in.ibm.com, torvalds@osdl.org,
       anton@samba.org, linux-kernel@vger.kernel.org, miltonm@bga.com,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] ppc64: kexec support for ppc64
In-Reply-To: <20050506173211.0bc2db7e.akpm@osdl.org>
References: <20050506160546.388aeed4.akpm@osdl.org>
	<E1DUCQS-0005Sq-00@w-gerrit.beaverton.ibm.com>
	<20050506173211.0bc2db7e.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> But you didn't address the question of whether the kexec feature is
> sufficiently useful in its own right to justify merging.

On POWER4 boxes running in SMP (non-partitioned) mode it would be
extremely useful, because the firmware takes such an age to boot the
machine.

Paul.
