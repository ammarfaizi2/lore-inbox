Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTHLNSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270325AbTHLNSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:18:36 -0400
Received: from f22.mail.ru ([194.67.57.55]:32019 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S270322AbTHLNSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:18:35 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: herbert@13thfloor.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 12 Aug 2003 17:22:13 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mZ6L-000Jrv-00.arvidjaar-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>        cannot mount rootfs "NULL" or hdb1
>
> AFAIK, there is no such message in 2.6.0-test3 ...

there is


> if, on the other hand, the message looks like ...
>
> -----------
> VFS: Cannot open root device "hdb1" or unknown-block(0,0)
> Please append a correct "root=" boot option
> -----------

he does not pass it in append line. He is using root= option in lilo.
actually my lilo does pass "root=341" in this case while the above means lilo omits any root= command line option and relies on compiled-in ROOT_DEV




