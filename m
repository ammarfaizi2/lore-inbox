Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUC1RcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUC1Rby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:31:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262153AbUC1RbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:31:18 -0500
Message-ID: <40670BD9.9020707@pobox.com>
Date: Sun, 28 Mar 2004 12:31:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de>
In-Reply-To: <20040328141014.GE24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Mar 27 2004, Jeff Garzik wrote:
> 
>>I also wouldn't want to lock out any users who wanted to use SATA at 
>>full speed ;-)
> 
> 
> And full speed requires 32MB requests?


Full speed is the SATA driver supporting the hardware maximum.  The 
block layer and general fragmentation limit things further from there.

	Jeff



