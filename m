Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbTGJKEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbTGJKEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:04:43 -0400
Received: from f25.mail.ru ([194.67.57.151]:42760 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S269166AbTGJKEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:04:42 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Nikita Danilov=?koi8-r?Q?=22=20?= 
	<Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Are =?koi8-r?Q?=22?=,=?koi8-r?Q?=22=20?=and =?koi8-r?Q?=22?=..=?koi8-r?Q?=22=20?=in directory required=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 10 Jul 2003 14:19:21 +0400
In-Reply-To: <16141.14720.980604.428130@laputa.namesys.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> "Andrey Borzenkov"  writes:
>  > 
>  > Is it possible for readdir to return really empty directory - without
>  > and entry, even "." and ".."?
> 
> Enter empty directory. Remove it by rmdir() by another process. Now you
> have a directory without dot and dotdot.
> 

It is not quite the same.

bor@itsrm2% cd foo
bor@itsrm2% sudo rmdir /tmp/foo
bor@itsrm2% ls -la .
.: No such file or directory

how do I access this? OK I could have opendir on it ... but then,
directory contents is (mur be) still there just like with any
open unlinked file.

OK, not "possible to return" - it was wrong. Is it allowed? :)

-andrey
