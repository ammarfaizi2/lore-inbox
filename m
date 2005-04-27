Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVD0Wa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVD0Wa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVD0W1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:27:09 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:34564 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262073AbVD0WZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:25:06 -0400
Message-ID: <427010FB.4080706@rtr.ca>
Date: Wed, 27 Apr 2005 18:23:55 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en, en-us
MIME-Version: 1.0
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: any way to find out kernel memory usage?
References: <426FBFED.9090409@nortel.com> <426FC0FE.2090900@oktetlabs.ru>	 <426FC46C.4070306@nortel.com> <1114622438.10836.8.camel@betsy>	 <426FCF7B.5020806@nortel.com> <1114624035.10836.19.camel@betsy>
In-Reply-To: <1114624035.10836.19.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about in your private kernel build (Chris),
instrument alloc_pages() and free_pages() to maintain
a simple running tally of GFP_KERNEL and GFP_ATOMIC
page allocation counts ?

I wonder if that would catch all kernel allocations?

Cheers
