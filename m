Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbTGJLcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbTGJLcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:32:25 -0400
Received: from f15.mail.ru ([194.67.57.45]:11024 "EHLO f15.mail.ru")
	by vger.kernel.org with ESMTP id S269216AbTGJLcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:32:24 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Nikita Danilov=?koi8-r?Q?=22=20?= 
	<Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are =?koi8-r?Q?=22?=,=?koi8-r?Q?=22=20?=and =?koi8-r?Q?=22?=..=?koi8-r?Q?=22=20?=in directory required=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 10 Jul 2003 15:47:04 +0400
In-Reply-To: <16141.16899.777319.699253@laputa.namesys.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19aZtA-000MFD-00.arvidjaar-mail-ru@f15.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>  > bor@itsrm2% cd foo
>  > bor@itsrm2% sudo rmdir /tmp/foo
>  > bor@itsrm2% ls -la .
>  > .: No such file or directory
>  > 
>  > how do I access this? OK I could have opendir on it ... but then,
> 
> You should access it through getcwd(2).  Try 'ls -al'. readdir has
> special case for such directories (IS_DEADDIR), so it will come up as
> empty without dot and dotdot.
> 

OK I tried it not under Linux the first time.

Tnx

-andrey


