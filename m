Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTHMGKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbTHMGKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:10:13 -0400
Received: from f16.mail.ru ([194.67.57.46]:9988 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S271391AbTHMGKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:10:10 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 and rootflags
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 13 Aug 2003 10:10:00 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mopc-000Mqv-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If there's a consensus that a 'rootopts=' would be a Good Thing, I'll write a
> patch.  If not, I'll just fix the initial value of root_mountflags > in init/do_mount.c ;)

Mandrake does it in initrd - if mkinitrd detects any non-standard
rootfs option in use it makes it be mounted from within initrd.

Drawback is you can't change them on the fly. Unfortunately parsing
rootfstype/rootflags in initrd is not trivial given size constraints.

-andrey


