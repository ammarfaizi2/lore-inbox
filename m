Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTGJJrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269145AbTGJJrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:47:07 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9869 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S269144AbTGJJrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:47:04 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.14720.980604.428130@laputa.namesys.com>
Date: Thu, 10 Jul 2003 14:01:36 +0400
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are =?koi8-r?Q?=22?=,=?koi8-r?Q?=22=20?=and =?koi8-r?Q?=22?=..=?koi8-r?Q?=22=20?=in directory required=?koi8-r?Q?=3F?=
In-Reply-To: <E19aWbo-00031x-00.arvidjaar-mail-ru@f16.mail.ru>
References: <E19aWbo-00031x-00.arvidjaar-mail-ru@f16.mail.ru>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Borzenkov"  writes:
 > 
 > Is it possible for readdir to return really empty directory - without
 > and entry, even "." and ".."?

Enter empty directory. Remove it by rmdir() by another process. Now you
have a directory without dot and dotdot.

 > 
 > TIA
 > 
 > -andrey

Nikita.
