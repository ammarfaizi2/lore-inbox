Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUBCEf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUBCEf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:35:56 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:52609
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265711AbUBCEfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:35:55 -0500
Message-ID: <401F251C.2090300@redhat.com>
Date: Mon, 02 Feb 2004 20:35:40 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random>
In-Reply-To: <20040201012803.GN26076@dualathlon.random>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> I definitely call it a great success,

You got to be kidding.  Some object fixed in the address space which can
perform system calls.  Nothing is more welcome to somebody trying to
exploit some bugs.

The vdso must be randomized.  This is completely impossible with this
stupid fixed address scheme and it must be changed as soon as possible.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
