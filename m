Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVBYAac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVBYAac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVBYA3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:29:42 -0500
Received: from terminus.zytor.com ([209.128.68.124]:36322 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262625AbVBYATk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:19:40 -0500
Message-ID: <421E6F10.4060205@zytor.com>
Date: Thu, 24 Feb 2005 16:19:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: raid6altivec does not compile on ppc32
References: <jebra9fq6t.fsf@sykes.suse.de>
In-Reply-To: <jebra9fq6t.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> On ppc32 cur_cpu_spec is an array of pointers, not just a pointer like on
> ppc64.
> 
> drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
> drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union
> 

I think this is being discussed on the ppc development list.  It's 
apparently turned into a "we have a problem, let's fix it the right way."

	-hpa
