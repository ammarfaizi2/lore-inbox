Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVDRQrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVDRQrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRQrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:47:15 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:43163 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262130AbVDRQq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:46:59 -0400
Message-ID: <4263E445.8000605@ammasso.com>
Date: Mon, 18 Apr 2005 11:45:57 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org>
In-Reply-To: <20050418164316.GA27697@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Apr 18, 2005 at 11:22:29AM -0500, Timur Tabi wrote:
> 
>>That's not what we're seeing.  We have hardware that does DMA over the 
>>network (much like the Infiniband stuff), and we have a testcase that fails 
>>if get_user_pages() is used, but not if mlock() is used.
> 
> 
> If you don't share your testcase it's unlikely to be fixed.

As I said, the testcase only works with our hardware, and it's also very large.  It's one 
small test that's part of a huge test suite.  It takes a couple hours just to install the 
damn thing.

We want to produce a simpler test case that demonstrates the problem in an 
easy-to-understand manner, but we don't have time to do that now.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
