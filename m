Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSFNLOl>; Fri, 14 Jun 2002 07:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSFNLOl>; Fri, 14 Jun 2002 07:14:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:20005 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317597AbSFNLOh>;
	Fri, 14 Jun 2002 07:14:37 -0400
Date: Fri, 14 Jun 2002 13:15:05 +0200
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: insmod stall
Message-Id: <20020614131505.00004803.diemer@gmx.de>
X-Mailer: Sylpheed version 0.7.6claws31 Win32 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a recent debian woody. I want to use the fritz card usb. I
downloaded and compiled it (its distributed partly binary, part source).
Usign the debian kernel-image-2.4.18-686, the driver worked. Now I have
compiled my own kernel (2.4.18 too). Now, the driver doesn't work
anymore (although I recompiled it against my new kernel sources): when I
insmod it, I see the messages that appeared with the woody kernel, lsmod
shows the module, but insmod doesn't exit (i.e. it's listed when i run
"ps ax" as running (Status R)). when I kill that process, the cpu load
rises. top shows a process named fcusb_init (if I remember correctly)
taking 99% of the cpu time.

What's going wrong here? Have I forgotten something? how come the driver
worked with the woody kernel and wouldn't work with a self compiled one?

regards

Jonas

PS: Please CC me in your replys, I am not subscribed to the list.
