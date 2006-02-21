Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWBUPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWBUPdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWBUPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:33:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932529AbWBUPdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:33:46 -0500
Message-ID: <43FB331F.9020104@ce.jp.nec.com>
Date: Tue, 21 Feb 2006 10:34:55 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md)
References: <43F60F31.1030507@ce.jp.nec.com> <20060217194249.GO12169@agk.surrey.redhat.com> <43F6769C.5010505@ce.jp.nec.com> <20060218195347.GU12169@agk.surrey.redhat.com>
In-Reply-To: <20060218195347.GU12169@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon wrote:
>>Speaking about the efficiency, 'dmsetup ls --tree' works well.
>>However, I haven't yet found a efficient way to implement
>>'dmsetup info --tree -o inverted dm-0', for example.
>  
> Indeed - but what needs this that doesn't also need to scan
> everything?    mount?

mount, fsck and other blkid based tools could be optimized with it.
However, what I had in mind was system administration like just
using dmsetup or looking /sys to check where a device belongs.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
