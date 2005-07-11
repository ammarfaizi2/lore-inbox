Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVGKB7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVGKB7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVGKB7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:59:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:65163 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262190AbVGKB7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:59:03 -0400
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jul 2005 03:59:00 +0200
In-Reply-To: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>
Message-ID: <p73eka614t7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why per node? Why not go the whole way and make it per CPU?

I would also not define it statically, but allocate it at boot time
in node local memory.

-Andi
