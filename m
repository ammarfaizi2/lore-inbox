Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUJQA0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUJQA0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268978AbUJQA0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:26:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268972AbUJQA0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:26:05 -0400
Message-ID: <4171BC0F.70901@pobox.com>
Date: Sat, 16 Oct 2004 20:25:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org>
In-Reply-To: <20041016171458.4511ad8b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>I'd be suspecting the vmscan.c change, but we allegedly fixed that later on.
>>
>> > Can you try reverting it?  (Can't reproduce the problem here)
>>
>>
>> Verified -- reverting the vmscan.c changeset (attached) fixed my hang.
> 
> 
> Can we get a sysrq-M dump from that machine please?

For which?  fixed or hung?

	Jeff


