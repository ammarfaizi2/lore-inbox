Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbSLaIGV>; Tue, 31 Dec 2002 03:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbSLaIGU>; Tue, 31 Dec 2002 03:06:20 -0500
Received: from comtv.ru ([217.10.32.4]:28579 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267185AbSLaIGU>;
	Tue, 31 Dec 2002 03:06:20 -0500
To: lkml <linux-kernel@vger.kernel.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: [ANNOUNCE] fast access to process list
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 31 Dec 2002 11:06:09 +0300
Message-ID: <m3n0mmzk7i.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day!

I'd like to present 2nd version of fastps.

Changes at kernel side:
  - common codebase for 2.4 and 2.5
  - filters incorporated (ability to select processes to be retreived)
  - possible deadlock removed
  - usage of for_each_task() reduced
  - O(1)-compatibility

Changes in userspace tool fps:
  - ability to select processes to be shown (see fps -h)
  - cleanups in output format
  - fps looks for System.map in several dirs

Patches against 2.4.20/2.5.53 and userspace tool may be found at
http://tmi.comex.ru/fps/


with best regards, Alex

