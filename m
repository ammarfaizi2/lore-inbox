Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVF0I50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVF0I50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVF0I50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:57:26 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:7612 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261948AbVF0I5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:57:17 -0400
X-IronPort-AV: i="3.93,234,1115017200"; 
   d="scan'208"; a="194479957:sNHT25822876"
Message-ID: <42BFBF5B.7080301@cisco.com>
Date: Mon, 27 Jun 2005 18:56:59 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org> <42BFB287.5060104@yahoo.com.au>
In-Reply-To: <42BFB287.5060104@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
[..]

> However I think for Oracle and others that use shared memory like
> this, they are probably not doing linear access, so that would be a
> net loss. I'm not completely sure (I don't have access to real loads
> at the moment), but I would have thought those guys would have looked
> into fault ahead if it were a possibility.

i thought those guys used O_DIRECT - in which case, wouldn't the page 
cache not be used?


cheers,

lincoln.
