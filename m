Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTDSDO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 23:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTDSDO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 23:14:27 -0400
Received: from ohsmtp01.ogw.rr.com ([65.24.7.36]:32902 "EHLO
	ohsmtp01.ogw.rr.com") by vger.kernel.org with ESMTP id S262930AbTDSDO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 23:14:26 -0400
Message-ID: <000901c30621$ee8f6c10$0200a8c0@satellite>
From: "Dave Mehler" <dmehler26@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: i8253 problem solved, rh9 2.5 kernel booting
Date: Fri, 18 Apr 2003 23:15:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    This message is a brief thanks to everyone who helped me through the
past week. With much help and many files i have solved the issue:
on my motherboard an Asus A7A266 i get an error:
"kernel: i8253 count too high! Resetting.."
    the suggested fix which did work was to compile a 2.5 kernel on rh9.
This i did but was unable to boot the system, i had compiled in framebuffer
console, keyboard, and mouse, and whateve r else was needed, but it hung
after the mkinitrd image was loaded. The solution was to update the mkinitrd
as well as procvutils and modutils.
    Again, thanks to all.
Dave.

