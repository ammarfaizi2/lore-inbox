Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVDZPZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVDZPZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDZPZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:25:57 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:42636 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261587AbVDZPZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:25:37 -0400
Message-ID: <426E5D13.6000200@ammasso.com>
Date: Tue, 26 Apr 2005 10:24:03 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org> <52r7gytnfn.fsf@topspin.com> <20050426061236.GA27220@infradead.org>
In-Reply-To: <20050426061236.GA27220@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> What doesn't work with that design are the braindead designed by comittee
> APIs in the RDMA world - but I don't think we should care about them too
> much.

I think you should.  The whole point behind RDMA is that these APIs exist and are being 
used by real-world applications.  You can't just ignore them because they're inconvenient. 
  If you're not willing to cater to these API's needs, then you may as well tell all the 
RDMA developers to forgot about Linux and port everything to Windows instead.

The APIs are here to stay, and the whole point behind this thread is to discuss how Linux 
can support them.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
