Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTIPPcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbTIPPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:32:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:38614 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261988AbTIPPca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:32:30 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 16 Sep 2003 17:32:25 +0200 (MEST)
Message-Id: <UTC200309161532.h8GFWPT14081.aeb@smtp.cwi.nl>
To: john@grabjohn.com, linux-kernel@vger.kernel.org, ndiamond@wta.att.ne.jp
Subject: Re: 2.6.0-test5 vs. APM or keyboard driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: "Norman Diamond" <ndiamond@wta.att.ne.jp>

    ...
    The above complaints all concern either APM or the keyboard driver.  I am
    not sure if the 2.6.0 keyboard driver could be the reason why the BIOS no
    longer even gets signals from the keyboard.  I have never seen any other
    situation where a keyboard's "Fn" key plus functional meaning of another
    key could get broken, so I'm not sure if a broken keyboard driver could
    really be this powerful.

Some versions of 2.6 combined with some keyboard versions
will set the keyboard to scancode mode 3. Some (most? all?)
BIOSes expect translated scancode mode 2 and do not work
in any other mode.

So, in case you have scancode mode set 3, change that.

So far we have heard about precisely one keyboard in the world
where scancode mode 3 was useful. It is the Japanese keyboard
of John Bradford. He once wrote

> My keyboard has a distinct ID, and works fine in set 3,

Let me repeat the question:
John: What ID does this keyboard report?

Andries
