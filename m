Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293228AbSBWVuc>; Sat, 23 Feb 2002 16:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293225AbSBWVuM>; Sat, 23 Feb 2002 16:50:12 -0500
Received: from pop.gmx.net ([213.165.64.20]:65065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293224AbSBWVuE>;
	Sat, 23 Feb 2002 16:50:04 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Input device support - twisted mouse wheel scrolling
Date: Sat, 23 Feb 2002 22:51:25 +0100
X-Mailer: KMail [version 1.3.99]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200202232251.25423.gjwucherpfennig@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the linux 2.5.5-dj1 and have a IMPS/2 mouse.
Since I've enabled input core support and changed the device name
( /dev/psaux --> /dev/input/mouse0 ) the mouse wheel
is scrolling the other way around. (I'm using KDE cvs)

A workaround is to change the ZAxisMapping option in XF86Config
from "4 5" to "5 4".

Gerold J. Wucherpfennig


