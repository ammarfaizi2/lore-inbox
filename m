Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTGXMlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTGXMlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:41:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:7649 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263875AbTGXMlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:41:03 -0400
Date: Thu, 24 Jul 2003 14:56:09 +0200
From: Dominik Brugger <ml.dominik83@gmx.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: OHCI problems with suspend/resume
Message-Id: <20030724145609.4a8c8e67.ml.dominik83@gmx.net>
In-Reply-To: <20030724143731.5fe40b4e.ml.dominik83@gmx.net>
References: <20030723220805.GA278@elf.ucw.cz>
	<20030724143731.5fe40b4e.ml.dominik83@gmx.net>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I have a few things to add:

1) If uhci_hcd was never loaded before suspend, one has to press a key on the keyboard after `echo 3 > /proc/acpi/sleep` in order to get the machine suspended. Wakeup does not work in that case, reboot required.

2) It makes no difference whether the Logitech USB Mouse is connected or not.

-Dominik Brugger
