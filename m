Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWA3JRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWA3JRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWA3JRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:17:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932156AbWA3JRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:17:01 -0500
Date: Mon, 30 Jan 2006 01:16:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: olaf+list.linux-kernel@olafdietsche.de, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
 filesystem
Message-Id: <20060130011630.60f402d8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>
	<200601231257.28796@bilbo.math.uni-mannheim.de>
	<87mzhgyomh.fsf@goat.bogus.local>
	<20060128150137.5ba5af04.akpm@osdl.org>
	<Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> 
> >> +static DECLARE_MUTEX(accessfs_sem);
> >
> >Please use a `struct mutex'.
> 
> You know what's irritating? That DECLARE_MUTEX starts a semaphore and
> DEFINE_MUTEX a mutex.
> 

DECLARE_MUTEX will go away.
