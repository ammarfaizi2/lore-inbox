Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUI2PNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUI2PNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUI2OxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:53:24 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:1762 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S268535AbUI2Osi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:48:38 -0400
Message-ID: <415ACB29.5000104@ammasso.com>
Date: Wed, 29 Sep 2004 09:48:09 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: get_user_pages() still broken in 2.6
References: <4159E85A.6080806@ammasso.com> <20040929000325.A6758@infradead.org>
In-Reply-To: <20040929000325.A6758@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> get_user_pages locks the page in memory.  It doesn't do anything about ptes.

I don't understand the difference.  I thought a locked page is one that 
stays in memory (i.e. isn't swapped out) and whose physical address 
never changes.  Is that wrong?  All I need to do is keep a page in 
memory at the same physical address until I'm done with it.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
