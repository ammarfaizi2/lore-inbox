Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWEKHQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWEKHQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWEKHQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:16:18 -0400
Received: from fmr17.intel.com ([134.134.136.16]:60127 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965185AbWEKHQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:16:18 -0400
Message-ID: <4462E474.9020200@linux.intel.com>
Date: Thu, 11 May 2006 09:15:00 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as unused-for-removal-soon
References: <1146581587.32045.41.camel@laptopd505.fenrus.org> <20060510233427.4306422b.pj@sgi.com>
In-Reply-To: <20060510233427.4306422b.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Arjan wrote:
>> This is patch one in a series of 17; to not overload lkml the other
>> 16 will be mailed direct; people who want to see them all can see
>> them at http://www.fenrus.org/unused
> 
> Well ... here's one case where your patch series is broken.
> 
> Argh - I almost missed this one.  My mailer is setup to tag all
> incoming lkml email that mentions the magic word 'cpuset'.  But
> it is not setup to catch indirect patches, needless to say.
> 
> One of your proposed changes (the only one I reviewed) removed the only
> EXPORT_SYMBOL_GPL in kernel/cpuset.c.  That EXPORT is needed because
> the routine in question is called from inlines which modules use.

not in the configs I tested at least... but maybe I need to add a specific config to
my set..
