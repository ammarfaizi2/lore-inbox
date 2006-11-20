Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966748AbWKTWDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966748AbWKTWDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966807AbWKTWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:03:45 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:6242 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966748AbWKTWDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:03:44 -0500
Message-ID: <4561B569.8030306@oracle.com>
Date: Mon, 20 Nov 2006 06:02:17 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 2/4][AIO] - export good_sigevent()
References: <20061120151700.4a4f9407@frecb000686> <20061120152244.275f425a@frecb000686> <4561B0BA.4050204@oracle.com> <45622201.9000908@redhat.com>
In-Reply-To: <45622201.9000908@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Zach Brown wrote:
>> I wonder if "good_sigevent()" isn't a very strong name for something
>> that is now up in signal.h.  Maybe "sigevent_find_task()"?
> 
> That's not the purpose, it's just one of the checks which need to be
> done to check that the sigevent value is "good".

Hmm?  It returns a task_struct *, potentially after finding it with
find_task_by_pid().

That said, I don't particularly care much.  It just jumped out as I was
reading it.

- z
