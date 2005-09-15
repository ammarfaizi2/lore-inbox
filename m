Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVIONN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVIONN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVIONN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:13:27 -0400
Received: from femail.waymark.net ([206.176.148.84]:57069 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1030402AbVIONN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:13:26 -0400
Date: 15 Sep 2005 13:11:46 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: 2.6.14-rc1[-git1]  was Re: [PROBLEM] mtrr's not set, 2.6.13
To: linux-kernel@vger.kernel.org
Message-ID: <503ff2.2f4177@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In 14 Sep 05  07:50:10 article, Kenneth Parrish wrote to All <=-
[..]
 KP> Linux fret 2.6.14-rc1 #6 Wed Sep 14 01:05:11 CDT 2005 i686 unknown
 KP> unknown GNU/Linux

 KP> p.s. this 2.6.14-rc1 kernel shows four lines plus one or two pixels
 KP> of the next line, at the bottom of each text console, filled with
 KP> what looks like earlier buffer. and it scrolls, with new output. ??

Linux fret 2.6.14-rc1-git1 #1 Thu Sep 15 06:40:15 CDT 2005 i686 unknown unknown
GNU/Linux

        i have noticed that on tty1 only, once the initial boot-up
messages are cleared from the buffer no new output is looped to the
bottom of the screen; but a few tests with a couple of the other five
configured tty's has showed new buffer content continually copies to the
last few lines (plus a pixel or three).
        i commented the vga=290 boot option and the problem remains,
just fewer surprious lines appear.

--
