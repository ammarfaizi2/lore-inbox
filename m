Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUIQGhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUIQGhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268472AbUIQGhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:37:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19126 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268450AbUIQGhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:37:24 -0400
Message-ID: <414A8614.5000807@pobox.com>
Date: Fri, 17 Sep 2004 02:37:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, David Miller <davem@redhat.com>,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
References: <20040917062042.GE6523@zax>
In-Reply-To: <20040917062042.GE6523@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Andrew, please apply:
> 
> When fib_create_info() allocates new hash tables, it neglects to
> initialize them.  This leads to an oops during boot on at least
> machine I use.  This patch addresses the problem.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>


This may be the oops in fib_xxx I just saw on my Athlon64 box...

	Jeff


