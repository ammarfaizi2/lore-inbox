Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWBVTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWBVTAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWBVTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:00:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:21463 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751123AbWBVTAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:00:43 -0500
Message-ID: <43FCB4D7.5090503@us.ibm.com>
Date: Wed, 22 Feb 2006 11:00:39 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and	mpage_readpages()
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>	 <20060222151216.GA22946@lst.de>	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com> <1140633437.9912.5.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1140633437.9912.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

> On Wed, 2006-02-22 at 08:58 -0800, Badari Pulavarty wrote:
> 
>>Thanks. Only current issue Nathan raised is, he wants to see
>>b_size change to u64 (instead of u32) to support really-huge-IO
>>requests. Does this sound reasonable to you ?
> 
> 
> Didn't someone point out that size_t would make more sense?  There's no
> reason for a 32-bit architecture to have a 64-bit b_size.

Yes. I meant to say size_t.

- Badari

