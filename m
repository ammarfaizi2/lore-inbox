Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSLAMd1>; Sun, 1 Dec 2002 07:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSLAMd1>; Sun, 1 Dec 2002 07:33:27 -0500
Received: from dyn-ctb-210-9-246-251.webone.com.au ([210.9.246.251]:5124 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261664AbSLAMd0>;
	Sun, 1 Dec 2002 07:33:26 -0500
Message-ID: <3DEA0374.2040306@cyberone.com.au>
Date: Sun, 01 Dec 2002 23:41:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
References: <3DE9C43D.61FF79C5@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>In 2.4.20-pre5 an optimisation was made to the ext3 fsync function
>which can very easily cause file data corruption at unmount time.  This
>was first reported by Nick Piggin on November 29th (one day after 2.4.20 was
>released, and three months after the bug was merged.  Unfortunate timing)
>
In fact it was reported on lkml on 18th July IIRC before 2.4.19 was
released if that is any help to you. 2.4.19 and 2.4.20 are affected
and I haven't tested previous releases. I was going to re-report it
sometime, but Alan brought it to light just the other day.

Nick

