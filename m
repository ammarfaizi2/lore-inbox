Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUAJBM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUAJBM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:12:59 -0500
Received: from sec17.secrel.com.br ([200.194.96.14]:25535 "HELO
	sec17.secrel.com.br") by vger.kernel.org with SMTP id S264471AbUAJBMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 20:12:54 -0500
Subject: USB keyboard misbehaves in 2.6.1
From: Marcelo Bezerra <mosca@mosca.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073697166.739.10.camel@ham>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 22:12:46 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a usb keyboard wich happens to also have a standard ps2 connector
(A microsft internet keyboard pro).
After booting in 2.6.1 one key (the one with ] and } on it) behaves like
print screen when I only connect it via usb, when I connect it to the
keyboard port as well it behaves correctly and prints the expected
characters.
My keyboard has a br-abnt2 layout, but I ignore this fact and load no
keymaps, since I prefer the us layout for historical reasons and it
should print \ and | as it does when not working as a usb keyboard.

This key generates keycode 84 in usb mode and 43 in standard mode.

Is there any other info that could be usefull?

