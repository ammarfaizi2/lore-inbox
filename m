Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWJRQWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWJRQWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWJRQWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:22:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:44678 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751489AbWJRQWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:22:31 -0400
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] 2.6.18-rt6 sysctl conflict
References: <20061018132530.GA30767@tsunami.ccur.com>
From: Andi Kleen <ak@suse.de>
Date: 18 Oct 2006 18:22:17 +0200
In-Reply-To: <20061018132530.GA30767@tsunami.ccur.com>
Message-ID: <p733b9ld26e.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

> Repair conflict between 2.6.18 and preempt-rt's sysctl(2) addition.

In general new sysctl shouldn't get any numbers at all. Just use 0
or so or 999. Distributions and other patches have mangled the 
numerical name so excessively that it is fairly useless for
any newer numbers. I would suggest to just drop them.

-Andi
