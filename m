Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJKJCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTJKJBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:01:49 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:55972 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263269AbTJKJBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:01:39 -0400
Message-ID: <228201c38fd6$32b82c90$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7 + X11 + screen savers vs. user
Date: Sat, 11 Oct 2003 18:00:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test1 through test7, when running X11, the screen saver kicks in
about every 5 minutes.  I haven't checked the configuration but have
confidence that it's obeying the timing correctly.  The problem is that it
doesn't care whether the keyboard and mouse have been used during that time.
When the screen saver is running, any keyboard or mouse activity will
restore the screen.  Also when the screen saver isn't running, the focused
window gets the input.  But it's irritating to be in the middle of typing or
mousing and suddenly lose a character or click because the screen saver
kicked in and gobbled up the next event.

