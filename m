Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWA3JrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWA3JrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWA3JrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:47:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54463 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932174AbWA3JrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:47:15 -0500
Date: Mon, 30 Jan 2006 10:47:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: reinitializing quota on xfs
In-Reply-To: <20060130201908.A8865130@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0601301032440.6405@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601291204380.18492@yvahk01.tjqt.qr>
 <20060130201908.A8865130@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi,
>> 
>> for some strange reason, `quota -v` showed an impossible number in the 
>> inodes (files) field, something that resembled 2^64 - n, n={1..100}. I do 
>
>It would be really good if we could get a test case for this; it
>gets reported once in a blue moon, so there does seem to be some
>latent issue there...
>
I'll try figure out a testcase.

>> not know how it happened, but I wanted to reinitialize the quota. Though, 
>> how does one do that with XFS? (Since it's different from the vfsv0 quota 
>> architecture.)
>
>See xfs_quota(8) from recent versions of xfsprogs, or in older
>ones theres doco in /usr/share/doc/xfsprogs*/README.quota.

I can't find it in xfsprogs-2.7.11/man/man8/xfs_admin.8 ... or it's too 
well hidden.



Jan Engelhardt
-- 
