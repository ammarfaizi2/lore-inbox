Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTEGU74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEGU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:59:56 -0400
Received: from ns.suse.de ([213.95.15.193]:9486 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264227AbTEGU7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:59:55 -0400
To: Will Dinkel <wdinkel@atipa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 interrupts handled by CPU0 only
References: <1052326953.22518.184.camel@zappa.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 May 2003 23:12:27 +0200
In-Reply-To: <1052326953.22518.184.camel@zappa.suse.lists.linux.kernel>
Message-ID: <p73wuh2zcjo.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Dinkel <wdinkel@atipa.com> writes:

> Are all interrupts supposed to be handled by CPU0 on x86_64, or is
> something amiss?  I'm getting the following on Mandrake Corporate Server
> 2.1:

It's by design. You need irqbalanced.

-Andi
