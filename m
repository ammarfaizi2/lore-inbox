Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbVHVWmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVHVWmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVHVWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:42:23 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:13196 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751434AbVHVWmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:42:20 -0400
To: e8607062@student.tuwien.ac.at
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
 (update)
References: <1124326652.8359.3.camel@w2>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 Aug 2005 23:15:33 -0600
In-Reply-To: <1124326652.8359.3.camel@w2> (Wieland Gmeiner's message of
 "Thu, 18 Aug 2005 02:57:31 +0200")
Message-ID: <m1zmratuve.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wieland Gmeiner <e8607062@student.tuwien.ac.at> writes:

> (This resembles the behaviour of the ptrace system call.)

ptrace does not solve this problem because?

If you can do this now without a syscall why do you need
a syscall to optimize this code path?

Eric
