Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267204AbTGHLMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGHLMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:12:00 -0400
Received: from ns.suse.de ([213.95.15.193]:35339 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267204AbTGHLL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:11:56 -0400
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2003 13:26:31 +0200
In-Reply-To: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
Message-ID: <p73brw5qmxk.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> writes:

> dynamic locks. supports exclusive and shared locks. exclusive lock may
> be taken several times by first owner.

What's the difference between these locks and the existing rw semaphores?

-Andi
