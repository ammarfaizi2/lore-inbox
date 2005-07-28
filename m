Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVG1AyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVG1AyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 20:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVG1AyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 20:54:07 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:43634 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261185AbVG1AyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 20:54:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pmlejzeSoGNNTM3s6YPIofryFZ9G3XxNOdCPzC545aXZgKBjfAEY0LKTzpZ9bTtX8TNWix82nNCsQ2e3aB7LsMwqySIZsHuRkVcaIM38xIeeVraRiZyFqwuyWIVT3X//31nXpOlVy5kQm/tX44wtJJU/SoxhncYb8pug9alHrGo=  ;
Message-ID: <42E82CA0.9080408@yahoo.com.au>
Date: Thu, 28 Jul 2005 10:53:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/6] mm: micro-optimise rmap
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au>	 <42E5F19A.6050407@yahoo.com.au> <1122463805.1166.3.camel@localhost.localdomain>
In-Reply-To: <1122463805.1166.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
>> void page_add_anon_rmap(struct page *page,

> 
> linear_page_index() here too?
> 

Hi Alexander,

Yes, that's what patch 3/6 did :)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
