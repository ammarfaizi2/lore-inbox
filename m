Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbTGUGJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbTGUGJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:09:37 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:29917 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S269270AbTGUGJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:09:36 -0400
Message-ID: <0c1801c34f50$a9706800$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Tried to run 2.6.0-test1 
Date: Mon, 21 Jul 2003 15:23:06 +0900
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

I wrote:

> I've downloaded modutils-2.4.21-18.src.rpm from Rusty Russell's directory
[...]
> Odds are I can probably gunzip and tar and compile the new modutils, but
> will the resulting executables get installed into the right places without
> using the rpm command and its spec file, I'm not sure I want to chance it.

I read the two README files and started to try building the first one
starting with "./configure --prefix=/" as directed.  It said:
  /home/ndiamond/modutils-2.4.21-18/SOURCES/module-init-tools-0.9.11a/missing: Unknown `--run' option
  Try `/home/ndiamond/modutils-2.4.21-18/SOURCES/module-init-tools-0.9.11a/missing --help' for more information

I tried that command for help.  Indeed it says there's no such thing as a
"--run" option.  Looks like I lied.  I don't know how to compile the new
module utilities.

One thing is interesting though.  This configure script figured out that my
cpu is an i586.

By the way, the last line in that README file says that if this is all too
complicated then install the source RPM.  Gee thanks.  I already tried
"rpm --rebuild" but it assumes an i686.

