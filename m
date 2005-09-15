Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVIOC3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVIOC3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVIOC3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:29:49 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:58523 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S1030348AbVIOC3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:29:48 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, chuckw@quantumlinux.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 14 Sep 2005 19:29:34 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address,not
 just low 1 byte
In-Reply-To: <20050914192652.02cf8fd8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509141929010.8469@qynat.qvtvafvgr.pbz>
References: <20050915010343.577985000@localhost.localdomain><20050915010404.660502000@localhost.localdomain><Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
 <20050914192652.02cf8fd8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Andrew Morton wrote:

> David Lang <dlang@digitalinsight.com> wrote:
>>
>> didn't Linus find similar bugs in a couple of the other hpt drivers as
>>  well? if so can they be fixed at the same time?
>
> Adam Kropelin did a sweep and picked up four similar cases.  I queued the
> patches and they should be considered for 2.6.13.3
>

Thanks,

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
