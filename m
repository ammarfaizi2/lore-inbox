Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268545AbTANC7E>; Mon, 13 Jan 2003 21:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268527AbTANC6y>; Mon, 13 Jan 2003 21:58:54 -0500
Received: from [212.180.52.86] ([212.180.52.86]:37034 "HELO
	hubert.heliogroup.fr") by vger.kernel.org with SMTP
	id <S268544AbTANC5g>; Mon, 13 Jan 2003 21:57:36 -0500
From: Hubert Tonneau <hubert.tonneau@pliant.cx>
To: linux-kernel@vger.kernel.org
Subject: NONBLOCK to USB printer on 2.4.20
Date: Tue, 14 Jan 2003 03:05:40 GMT
Message-ID: <030OB9H11@hubert.heliogroup.fr>
X-Mailer: Pliant 80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing with NONBOCK flag set to an USB printer device does not seem to work
on kernel 2.4.20 (probably some bytes are written before EAGAIN error is
returned to the application)
Seems to work properly for parallel port printer.
