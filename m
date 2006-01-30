Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWA3Jtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWA3Jtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWA3Jtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:49:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63167 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932180AbWA3Jta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:49:30 -0500
Date: Mon, 30 Jan 2006 10:49:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yuki Cuss <celtic@sairyx.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Don't hash pid 0.
In-Reply-To: <43DDE009.9090104@sairyx.org>
Message-ID: <Pine.LNX.4.61.0601301047200.6405@yvahk01.tjqt.qr>
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.61.0601301028510.6405@yvahk01.tjqt.qr> <43DDE009.9090104@sairyx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How about nr==0, it would make it more obvious.
>
> I am inclined to agree. `!nr' seems to imply some sort of an error condition;

! seems to imply a boolean usually. (If this was Java, this would even 
be enforced.)
However, !x (and x) is scattered all around the kernel where 
x==0,x!=0 (or x==NULL,x!=NULL) would be more readable.

> perhaps a comment could be placed in order to make why the case of (nr == 0) is
> being ignored.
>
> - Yuki.
>

Jan Engelhardt
-- 
