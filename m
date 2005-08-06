Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVHFLyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVHFLyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 07:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVHFLyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 07:54:45 -0400
Received: from mail.suse.de ([195.135.220.2]:56245 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261916AbVHFLyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 07:54:45 -0400
To: Dave Jiang <djiang@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Aug 2005 13:54:41 +0200
In-Reply-To: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel>
Message-ID: <p73slxn1dry.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang <djiang@mvista.com> writes:
> 
> Am I doing something wrong, or is this intended to be this way on
> x86_64, or is something incorrect in the kernel? This method works
> fine on i386. Thanks for any help!

I just tested your program on SLES9 with updated kernel and RBP
looks correct to me. Probably something is wrong with your user space
includes or your compiler.

-Andi
