Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWA3JYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWA3JYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWA3JYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:24:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42221 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932163AbWA3JYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:24:45 -0500
Date: Mon, 30 Jan 2006 10:24:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: olaf+list.linux-kernel@olafdietsche.de, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing filesystem
In-Reply-To: <20060130011630.60f402d8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local> <200601231257.28796@bilbo.math.uni-mannheim.de>
 <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
 <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr> <20060130011630.60f402d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> +static DECLARE_MUTEX(accessfs_sem);
>> >
>> >Please use a `struct mutex'.
>> 
>> You know what's irritating? That DECLARE_MUTEX starts a semaphore and
>> DEFINE_MUTEX a mutex.
>
>DECLARE_MUTEX will go away.

And be replaced by... DEFINE_SEMAPHORE?


Jan Engelhardt
-- 
