Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSATOeI>; Sun, 20 Jan 2002 09:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288645AbSATOds>; Sun, 20 Jan 2002 09:33:48 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:1086 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S288639AbSATOdh>;
	Sun, 20 Jan 2002 09:33:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Diego Fernandez Santos <coserycantar@terra.es>
Reply-To: coserycantar@terra.es
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Jan 2002 15:27:59 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120143347Z288639-13996+8634@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!, I have try to make the 2.5.2 kernel but the next error is raised:
	make[3]: Cambiando a directorio `/usr/src/linux-2.5.2/drivers/video'
	aty128fb.c:1707: incompatible types in assignment
the problem are in the kdev_t type, aty128fb.c wait a unsigned short but the 
kdev_t is a struct.
--> "fb_info.node=-1"

sorry by mailbug format.
