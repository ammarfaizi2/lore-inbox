Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEALjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTEALjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:39:31 -0400
Received: from tomts21-srv.bellnexxia.net ([209.226.175.183]:47072 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261216AbTEALja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:39:30 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [BENCHMARK] 2.5.68-mm3 with contest
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Thu, 01 May 2003 07:52:20 -0400
References: <fa.i2rq9k6.40evjg@ifi.uio.no> <fa.hp8a369.1t0qqpt@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030501115221.A85BC11B0B@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> All the io-write based loads were affected.
> 
> Yup.  Mainly because the large queue increases truncate latencies.

Are there loads that do benefit from large queues?  If so, does it make
sense to use truncate impact (something like a decaying average of truncate
time per interval) to control the size of the queues on the fly?

Comments
Ed Tomlinson
