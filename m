Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUIXA2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUIXA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUIXA2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:28:09 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:57465 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267614AbUIXAYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:24:50 -0400
Message-ID: <4153688F.3080806@yahoo.com.au>
Date: Fri, 24 Sep 2004 10:21:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-fs-devel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>
In-Reply-To: <4152F46D.1060200@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt wrote:

> There are a few exception cases which still concern me.
> 1. pages already in cache
> 2. I/O queue congestion.

I've always thought readahead should be done whether the IO queue is
congested or not.
