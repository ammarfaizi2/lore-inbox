Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSJLR50>; Sat, 12 Oct 2002 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJLR50>; Sat, 12 Oct 2002 13:57:26 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:24896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261304AbSJLR5Z>;
	Sat, 12 Oct 2002 13:57:25 -0400
Date: Sat, 12 Oct 2002 20:03:20 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42
Message-Id: <20021012200320.009295e6.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Great work. My Girlfriend's Vaio GR114EK seems more or less to be happy with 2.5.42.

But there are (of course) some problems:

1. Doing 'make menuconfig' I can't activate ACPI sleep states. It always falls back. Strange...

2. When I try to load uhci-hcd, I get the following error message:

Oct 12 17:32:29 tuxli kernel: Debug: sleeping function called from illegal conte
xt at include/asm/semaphore.h:119
Oct 12 17:32:29 tuxli kernel: Call Trace: [__might_sleep+84/96]  [<d0849436>]  [
<d083fa8d>]  [<d0849436>]  [<d083fd15>]  [<d083fce0>]  [default_wake_function+0/
52]  [<d084ca6c>]  [<d084ca6c>]  [kernel_thread_helper+5/12]

3. After loading eepro100 I reach the network with ping's but when I generate other traffic like downloading or getting E-Mails the card hangs. But there are no error messages in the log-files:-( 
A similar error also occures in the 2.4.19 kernel. After some traffic with ssh the connection hangs. Therefore I use 2.4.18 which is running fine at the moment - altough there are some troubles with irq-routing, because the missing acpi support.

4. I'm unable to get the usb-mouse working. I've loaded the ehci-hcd, uinput, hid module. I'm also unsuccessful with the usbmouse module.:-( 
Tips are welcome:-)

Kind regards

Marc Giger
