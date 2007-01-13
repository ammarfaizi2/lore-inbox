Return-Path: <linux-kernel-owner+w=401wt.eu-S1422759AbXAMT3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbXAMT3I (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 14:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbXAMT3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 14:29:08 -0500
Received: from mail.tmr.com ([64.65.253.246]:43082 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422759AbXAMT3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 14:29:06 -0500
Message-ID: <45A9336E.3050807@tmr.com>
Date: Sat, 13 Jan 2007 14:30:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: 7eggert@gmx.de, Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT question
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it> <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it> <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it> <7CBFn-hw-1@gated-at.bofh.it> <7CBP1-KI-3@gated-at.bofh.it> <7CBYG-WK-3@gated-at.bofh.it> <E1H5m8l-0000ns-9e@be1.lrz>
In-Reply-To: <E1H5m8l-0000ns-9e@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

> (*) This would allow fadvise_size(), too, which could reduce fragmentation
>     (and give an early warning on full disks) without forcing e.g. fat to
>     zero all blocks. OTOH, fadvise_size() would allow users to reserve the
>     complete disk space without his filesizes reflecting this.

Please clarify how this would interact with quota, and why it wouldn't 
allow someone to run me out of disk.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
