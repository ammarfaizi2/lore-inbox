Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbTILES2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTILES2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:18:28 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:20610 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S261653AbTILES1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:18:27 -0400
Message-ID: <3F614912.3090801@genebrew.com>
Date: Fri, 12 Sep 2003 00:18:26 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030908 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rusty@linux.co.intel.com
CC: riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
In-Reply-To: <200309120219.h8C2JANc004514@penguin.co.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [141.152.250.151] at Thu, 11 Sep 2003 23:18:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch wrote:
> The patch below uses a notifier list for other components to register
> to be called when an out of memory condition occurs.

How does this interact with the overcommit handling? Doesn't strict 
overcommit also not oom, but rather return a memory allocation error? 
Could we not add another overcommit mode where oom conditions cause a 
kernel panic?

Thanks,
Rahul

