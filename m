Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWBZBX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWBZBX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 20:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBZBX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 20:23:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17338 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751026AbWBZBXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 20:23:55 -0500
Message-ID: <4401032A.10406@sgi.com>
Date: Sat, 25 Feb 2006 19:23:54 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
CC: linux-xfs@oss.sgi.com,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       nathans@sgi.com
Subject: Re: testing 2.6.14-rc4: unmountable fs after xfs_force_shutdown
References: <4400C94A.7070001@dgreaves.com>
In-Reply-To: <4400C94A.7070001@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
> haze:~# mount /scratch
> mount: /dev/video_vg/video_lv: can't read superblock
> 
> haze:~# xfs_repair -n /dev/video_vg/video_lv
> Phase 1 - find and verify superblock...
> superblock read failed, offset 0, size 524288, ag 0, rval 0

First, why can't it be read?  any kernel messages as a result?  can you 
do a simple dd -from- this block device?

-Eric
