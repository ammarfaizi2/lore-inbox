Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbTGUGm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbTGUGm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:42:59 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:59570 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S269290AbTGUGm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:42:58 -0400
Message-ID: <0c3201c34f55$4e949280$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Tried to run 2.6.0-test1 
Date: Mon, 21 Jul 2003 15:56:30 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again I cannot keep up with the mailing list.  If anyone wishes to advise or
has questions, please kindly contact me directly.

In addition to my previous message quoting myself, I lied yet again:

> I've downloaded modutils-2.4.21-18.src.rpm from Rusty Russell's directory
[...]
> Odds are I can probably gunzip and tar and compile the new modutils, but
> will the resulting executables get installed into the right places without
> using the rpm command and its spec file, I'm not sure I want to chance it.

I read the two README files.  BOTH OF THE GZIPPED TARBALLS
PRODUCE THE SAME EXECUTABLE FILENAMES, such as insmod.
If I can get both of them to build, how can I guess which one to install?

Besides, I tried building module-init-tools-0.9.11a even after its configure
script failed.  There are a lot more differences than just the type of cpu,
from the compilation options when trying "rpm --rebuild".  For example no -D
options for combining various stuff, no URL to explain tainting, etc.  Also
this one's "make install" doesn't install the lsmod command.

I really really lied.  I'll never figure out how to build these things
without help.  As I understand it, all I need at this point is the new
modutils for execution on an i586.

