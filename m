Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWIHGjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWIHGjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIHGjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:39:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9345 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751814AbWIHGjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 02:39:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jean Delvare <jdelvare@suse.de>, Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] proc-readdir-race-fix-take-3-fix-3
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
	<200609061101.11544.jdelvare@suse.de>
	<200609062312.57774.jdelvare@suse.de> <20060906222556.GA168@oleg>
	<20060906223838.GA198@oleg>
Date: Fri, 08 Sep 2006 00:38:02 -0600
In-Reply-To: <20060906223838.GA198@oleg> (Oleg Nesterov's message of "Thu, 7
	Sep 2006 02:38:38 +0400")
Message-ID: <m1ac5an9rp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok.  While we are on the topic of races in readdir in /proc.
I just wanted to note that I believe thread groups have the same
potential problem.

I don't think it is severe enough to cause any real world problems.

But it makes sense to note it.

Something to think about.


Eric
