Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTEBAEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTEBAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:04:19 -0400
Received: from sj-core-5.cisco.com ([171.71.177.238]:3495 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP id S262820AbTEBACg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:02:36 -0400
Message-Id: <5.1.0.14.2.20030502101221.02c8fe28@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 02 May 2003 10:13:40 +1000
To: Willy TARREAU <willy@w.ods.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Cc: hugang <hugang@soulinfo.com>, akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030501135204.GC308@pcw.home.local>
References: <20030501150557.6dc913f7.hugang@soulinfo.com>
 <200304300446.24330.dphillips@sistina.com>
 <20030430135512.6519eb53.akpm@digeo.com>
 <20030501130318.459a4776.hugang@soulinfo.com>
 <20030430221129.11595e2e.akpm@digeo.com>
 <20030501133307.158c7e10.hugang@soulinfo.com>
 <20030501150557.6dc913f7.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:52 PM 1/05/2003 +0200, Willy TARREAU wrote:
>Ok, I recoded the tree myself with if/else, and it's now faster than all 
>others,
[..]
>4294967295 iterations of nil... checksum = 4294967295
>4294967295 iterations of old... checksum = 4294967265
>4294967295 iterations of new... checksum = 4294967265
>4294967295 iterations of fls_table... checksum = 4294967264
>4294967295 iterations of fls_tree... checksum = 4294967265

yep - faster - but with different results.
shouldn't the checksums be the same????


cheers,

lincoln.

