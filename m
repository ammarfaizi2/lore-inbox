Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWBVRMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWBVRMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBVRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:12:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751140AbWBVRMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:12:48 -0500
Message-ID: <43FC9BD4.1010901@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 12:13:56 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH 2/3] sysfs representation of stacked devices (dm) (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D92.6010006@ce.jp.nec.com> <20060222163438.GC31641@agk.surrey.redhat.com>
In-Reply-To: <20060222163438.GC31641@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alasdair G Kergon wrote:
 > This patch needs splitting up so that independent changes can be
 > considered separately.
 >
 > c.f. The proposal from Mike Anderson (repeated below) which I prefer
 > because it makes it clear that a table always belongs to exactly one md.

I like his proposed patch.
The interface is useful for my purpose too and moving table
creation inside _hash_lock means I don't need dm_get() neither.

Is it going to be pushed to upstream?
I'll remake my patch based on it.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
