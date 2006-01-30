Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWA3Jcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWA3Jcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWA3Jcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:32:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932158AbWA3Jcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:32:41 -0500
Date: Mon, 30 Jan 2006 01:32:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: olaf+list.linux-kernel@olafdietsche.de, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
 filesystem
Message-Id: <20060130013214.0da54582.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>
	<200601231257.28796@bilbo.math.uni-mannheim.de>
	<87mzhgyomh.fsf@goat.bogus.local>
	<20060128150137.5ba5af04.akpm@osdl.org>
	<Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>
	<20060130011630.60f402d8.akpm@osdl.org>
	<Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >> >> +static DECLARE_MUTEX(accessfs_sem);
> >> >
> >> >Please use a `struct mutex'.
> >> 
> >> You know what's irritating? That DECLARE_MUTEX starts a semaphore and
> >> DEFINE_MUTEX a mutex.
> >
> >DECLARE_MUTEX will go away.
> 
> And be replaced by... DEFINE_SEMAPHORE?
> 

That would be logical.
