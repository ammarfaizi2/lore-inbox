Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUHQIw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUHQIw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHQIw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:52:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:13038 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268168AbUHQIuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:50:17 -0400
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: /bin/ls: cannot read symbolic link /proc/$$/exe: Permission
 denied
References: <20040816133730.GA6463@suse.de> <20040816223938.GA9133@suse.de>
	<je4qn28xoq.fsf@sykes.suse.de> <20040817052302.GA11448@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Is this an out-take from the ``BRADY BUNCH''?
Date: Tue, 17 Aug 2004 10:50:15 +0200
In-Reply-To: <20040817052302.GA11448@suse.de> (Olaf Hering's message of
 "Tue, 17 Aug 2004 07:23:02 +0200")
Message-ID: <jept5q9mig.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

>> > A better one, clear both new fields, just in case.
>> 
>> memset?
>
> perhaps too expensive, no idea.

I don't think that this part of compat_do_execve is exactly time critical.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
