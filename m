Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966788AbWKTVzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966788AbWKTVzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966737AbWKTVzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:55:21 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:25987 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966788AbWKTVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:55:19 -0500
Message-ID: <4561B0BA.4050204@oracle.com>
Date: Mon, 20 Nov 2006 05:42:18 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 2/4][AIO] - export good_sigevent()
References: <20061120151700.4a4f9407@frecb000686> <20061120152244.275f425a@frecb000686>
In-Reply-To: <20061120152244.275f425a@frecb000686>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +extern struct task_struct * good_sigevent(sigevent_t *);

I wonder if "good_sigevent()" isn't a very strong name for something
that is now up in signal.h.  Maybe "sigevent_find_task()"?

- z
