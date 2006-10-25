Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWJYN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWJYN6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWJYN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:58:49 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:31861 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030453AbWJYN6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:58:48 -0400
Message-ID: <453F6D90.4060106@sw.ru>
Date: Wed, 25 Oct 2006 17:58:40 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com>
In-Reply-To: <20792.1161784264@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Vasily Averin <vvs@sw.ru> wrote:
>> The patch adds this dentry into tail of the dentry_unused list.
> 
> I think that's reasonable.  I wonder if we can avoid removing it from the list
> in the first place, but I suspect it's less optimal.

Could you please explain this place in details, I do not understand why tail of
the list is better than head.
Also I do not understand why we should go to out in this case. Why we cannot use
next dentry in the list instead?

> Acked-By: David Howells <dhowells@redhat.com>


Thank you,
	Vasily Averin
