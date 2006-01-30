Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWA3JIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWA3JIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWA3JIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:08:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2446 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932144AbWA3JIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:08:11 -0500
Date: Mon, 30 Jan 2006 10:07:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       eike-kernel@sf-tec.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing filesystem
In-Reply-To: <20060128150137.5ba5af04.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local> <200601231257.28796@bilbo.math.uni-mannheim.de>
 <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static DECLARE_MUTEX(accessfs_sem);
>
>Please use a `struct mutex'.

You know what's irritating? That DECLARE_MUTEX starts a semaphore and
DEFINE_MUTEX a mutex.



Jan Engelhardt
-- 
