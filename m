Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUJPPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUJPPWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUJPPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:22:32 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:38822 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268582AbUJPPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:22:30 -0400
Message-ID: <41713CB3.3010005@namesys.com>
Date: Sat, 16 Oct 2004 08:22:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zaitsev <peter@mysql.com>
CC: linux-kernel@vger.kernel.org, vs <vs@thebsh.namesys.com>,
       Chris Mason <mason@suse.com>, Jeff Mahoney <jeffm@suse.com>
Subject: Re: Disk full and writting to pre-allocated area on ReiserFS
References: <1097876157.6553.22.camel@sphere.site>
In-Reply-To: <1097876157.6553.22.camel@sphere.site>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:

>Hi,
>
>I'm running SuSE 9.1  Kernel 2.6.5-7.108-default 
>But I would guess it applies to large variety of platforms as we have
>customers reporting the same problem.
>
>I'm using reiserfs:
>/dev/md0 on /data type reiserfs (rw,noatime,notail,data=writeback)
>
>The problem is in case of disk full condition,  "Disk full" error is
>being reported even if write happens to Pre-Allocated area, in my case
>to Innodb recovery log files.
>
>This is very unfortunate as in such case Innodb has no way but to
>terminate database server.  These logs are specially pre-allocated so 
>one would not run in such condition.
>
>Question: Is there any way to avoid this problem with Reiserfs ? 
>
>
>  
>
vs or chris or jeff, can you comment?
