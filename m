Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265586AbUEZNCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUEZNCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUEZNAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:00:38 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7350 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265582AbUEZNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:00:11 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 06:03:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B48C78.6040005@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDHMqToSOQGm/VSjiKdHxE/58ETQABB0jw
Message-Id: <S265582AbUEZNAL/20040526130011Z+1843@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Couple that with the fact that there are many pte's pointing at the same
>> physical page (shared page) in many cases where many processes 
>>
>> are running
>> on the system. Because all of the references to that page must be removed
>> before the page can be evicted, there are some absolute 
>> limitations in the
>> rate that pages can be evicted from memory as the number of processes
>> running on the system and the total amount of memory increases.
>> 

> This is still many orders of magnitude faster than filling the page
> from disk, and you typically don't reclaim much of mapped memory anyway.

This discussion went broke-minded again. Your still picturing that single
IDE hard drive in your workstation and im talking about big iron, large
databases, etc.. where the total amount of aggregate disk I/O is completely
limited by the rate you can evict pages from the pagecache.

Picture 6 to 7 fibre channel cards with over 70% utilization during peak
usage times connected to a large EMC storage array with 64GB of non-volatile
cache.

--Buddy

