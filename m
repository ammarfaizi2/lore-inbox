Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966694AbWKTVx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966694AbWKTVx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966723AbWKTVx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:53:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30935 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966694AbWKTVxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:53:25 -0500
Message-ID: <45622201.9000908@redhat.com>
Date: Mon, 20 Nov 2006 13:45:37 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Zach Brown <zach.brown@oracle.com>
CC: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 2/4][AIO] - export good_sigevent()
References: <20061120151700.4a4f9407@frecb000686> <20061120152244.275f425a@frecb000686> <4561B0BA.4050204@oracle.com>
In-Reply-To: <4561B0BA.4050204@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> I wonder if "good_sigevent()" isn't a very strong name for something
> that is now up in signal.h.  Maybe "sigevent_find_task()"?

That's not the purpose, it's just one of the checks which need to be 
done to check that the sigevent value is "good".  I think the name is fine.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
