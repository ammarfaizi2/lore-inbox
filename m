Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUHKSGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUHKSGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268143AbUHKSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:06:36 -0400
Received: from zero.aec.at ([193.170.194.10]:14853 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268148AbUHKSGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:06:07 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [3/4] Jumper Probes patch to provide function arguments II 
References: <2s3ZE-7Zq-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <2s3ZE-7Zq-29@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Wed, 11 Aug 2004 18:20:10 +0200")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
Date: Wed, 11 Aug 2004 20:06:04 +0200
Message-ID: <m31xid4kj7.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

Small correction...

> max_t(unsigned long,MAX_STACK_SIZE, current_thread_info() + THREAD_SIZE - addr)
 
This should be (char *)current_thread_info() of course

-Andi

