Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266343AbSKGEkW>; Wed, 6 Nov 2002 23:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266345AbSKGEkW>; Wed, 6 Nov 2002 23:40:22 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:18866 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S266343AbSKGEkW> convert rfc822-to-8bit; Wed, 6 Nov 2002 23:40:22 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@digeo.com>
Subject: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
Date: Thu, 7 Nov 2002 05:47:00 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211070547.00387.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I enable shared 3rd-level pagetables between processes KDE 3.0.x and KDE 
3.1 beta2 at least do not work.

Especially "ksmserver" do not start anylonger.
Taken from my root's .xsession-errors file:

Mutex destroy failure: Device or resource busy
Mutex destroy failure: Device or resource busy
kdeinit: Pipe closed unexpectedly: No such file or directory
kdeinit: Pipe closed unexpectedly: Success
KInit could not launch 'ksmserver'.
kdeinit: Fatal IO error: client killed
ICE default IO error handler doing an exit(), pid = 4489, errno = 2
ICE default IO error handler doing an exit(), pid = 4497, errno = 0
kdeinit: Communication error with launcher. Exiting!
kdeinit: sending SIGHUP to children.
kdeinit: sending SIGTERM to children.
kdeinit: Exit.
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket
DCOPClient::attachInternal. Attach failed Could not open network socket

Any ideas?

Thanks,
	Dieter

