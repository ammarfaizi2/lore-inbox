Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWGDWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWGDWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWGDWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:25:57 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:21655 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932297AbWGDWZ4 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:25:56 -0400
Message-ID: <44AAEAF5.8040009@namesys.com>
Date: Tue, 04 Jul 2006 15:25:57 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, vs@namesys.com, Linux-Kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
References: <44A42750.5020807@namesys.com>	<20060629185017.8866f95e.akpm@osdl.org>	<1152011576.6454.36.camel@tribesman.namesys.com>	<20060704114836.GA1344@infradead.org>	<44AAA8ED.5030906@namesys.com> <20060704151832.9f2d87b3.akpm@osdl.org>
In-Reply-To: <20060704151832.9f2d87b3.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
> It's called at the same
>level as ->prepare_write/commit_write so if there's any logic to this, it's
>logical that batched_write be an a_op too.
>  
>
I agree that prepare_write/commit_write should be the same as
batch_write, but maybe they all should be file ops?

vs will send a patch which makes batch_write an a_op tomorrow.....

Hans
