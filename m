Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTKHAlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTKGWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:3258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264137AbTKGM4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 07:56:42 -0500
Date: Fri, 7 Nov 2003 13:56:41 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.0-test9] badness in local_bh_enable...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.105]
Message-ID: <23846.1068209801@www21.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came across this when pppd terminated it's connection recently.

What information would be useful for tracking this down?

Nov  6 21:17:41 [pppd] No response to 1 echo-requests
Nov  6 21:17:41 [pppd] Serial link appears to be disconnected.
Nov  6 21:17:47 [pppd] Connection terminated.
Nov  6 21:17:47 [pppd] Connect time 75.1 minutes.
Nov  6 21:17:47 [pppd] Sent 163567 bytes, received 275379 bytes.
Nov  6 21:17:48 [kernel] Badness in local_bh_enable at kernel/softirq.c:121
Nov  6 21:17:48 [kernel]  [<c02c2fc4>] pppoatm_pop+0x1f/0x44
Nov  6 21:17:48 [kernel]  [<c0144cca>] __fput+0xb3/0xc5

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

