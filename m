Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTL1CxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTL1CxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:53:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:15828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264935AbTL1CxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:53:23 -0500
Date: Sat, 27 Dec 2003 18:47:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is MCE?
Message-Id: <20031227184748.7db5c126.rddunlap@osdl.org>
In-Reply-To: <173d01c3cceb$08c0cda0$43ee4ca5@DIAMONDLX60>
References: <173d01c3cceb$08c0cda0$43ee4ca5@DIAMONDLX60>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 11:33:24 +0900 "Norman Diamond" <ndiamond@wta.att.ne.jp> wrote:

| Sometimes:
| MCE: The hardware reports a non fatal, correctable incident occurred on CPU
| 0.
| Bank 3: e20000000002010a
| 
| Sometimes:
| MCE: The hardware reports a non fatal, correctable incident occurred on CPU
| 0.
| Bank 3: a200000000080a01
| 
| Obviously this isn't a Linux error, Linux is being kind enough to report a
| hardware error to me, but I don't know how to interpret these error flags.
| I don't even know what MCE is but whoever developed it for Linux surely must
| know.  Please, how can I find out what this is?

It's an x86 Machine Check Exception, documented in the Intel
IA-32 docs.  And probably in some other x86-like docs.

There's a 'parsemce' program around that attempts to decode some
of those bits.  It might or might not help you out.
It's in this directory:
  http://www.kernel.org/pub/linux/kernel/people/davej/tools/

--
~Randy
