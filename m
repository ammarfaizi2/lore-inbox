Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUA0QZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUA0QZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:25:58 -0500
Received: from f13.mail.ru ([194.67.57.43]:522 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S265378AbUA0QZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:25:57 -0500
From: =?koi8-r?Q?=22?=Bansh=?koi8-r?Q?=22=20?= <bansh21@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: GPL license and linux kernel modifications
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.83.184]
Date: Tue, 27 Jan 2004 19:25:55 +0300
Reply-To: =?koi8-r?Q?=22?=Bansh=?koi8-r?Q?=22=20?= <bansh21@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've got a question, which I can't resolve myself about linux kernel binary code. The problem is GPL license which tells us that:

----------- cut COPYING -----------
The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.
----------- cut COPYING -----------

It gives the possibility to not distribute compiler and other preprocessing tools.
It looks like one can make a preprocessor or even one's own compiler (with one's syntax) which will be used for kernel building. But it's not required to distribute this compiler. So I can distribute linux kernel source code modified this way but no one will be able to build it. Is it ok?

Such compiler/preprocessor can be really very tricky and can hide the modifications very much, thus allowing to hide proprietary know-how.

Bansh
