Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129959AbQLIJ33>; Sat, 9 Dec 2000 04:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbQLIJ3J>; Sat, 9 Dec 2000 04:29:09 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25361 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129959AbQLIJ26>; Sat, 9 Dec 2000 04:28:58 -0500
Date: Sat, 9 Dec 2000 02:54:11 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: 2.2.18-25 has serious sickness with Xconfigurator
Message-ID: <20001209025411.A11269@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use of Xconfigurator with the 2.2.18-25 pre-patch causes hard hangs
and lockups on a 4 x PPro server.  I am using it with frame buffer 
support enabled, AGP enabled, and with the /dev/agpgart device
at maj 10 min 175 set to crw-rw-rw-.

XF86Setup runs fine provided you know what card or chipset you're on.
Whatever changed has broken the auto-probing in Xconfigurator.  During 
hardware probe, it just sits there and hangs.

The PS/2 mouse problems are gone, however.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
