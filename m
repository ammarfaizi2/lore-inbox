Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWGQH33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWGQH33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWGQH33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 03:29:29 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:24039 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932376AbWGQH31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 03:29:27 -0400
Message-ID: <44BB3C42.1060309@namesys.com>
Date: Mon, 17 Jul 2006 00:29:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeffrey Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com>
In-Reply-To: <44BB0146.7080702@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Mahoney wrote:

> Hans Reiser wrote:
>
> >Jeffrey Mahoney wrote:
>
> >>This is not
> >>the desired interpretation, which is why we need to replace the pathname
> >>separator in the name. ReiserFS is the component that is choosing to use
> >>the block device name as a pathname component and is responsible for
> >>making any translation to that usage.
>
> >This makes no sense.  I have the feeling you see trees and I see forest.
>
>
> No, Hans. I see a problem that has been fixed elsewhere in an identical
> manner. The real solution is to eliminate / from block devices in the
> long run, not to start introducing mount points with different pathname
> interpretation rules. Those may have a place elsewhere, after a tough
> uphill battle, and are most certainly overkill for this problem.
>
> -Jeff


I don't understand your patch and cannot support it as it is written.  
Perhaps you can call me and explain it on the phone.

Hans
