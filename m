Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSIJUuq>; Tue, 10 Sep 2002 16:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSIJUuq>; Tue, 10 Sep 2002 16:50:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31245 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318113AbSIJUup>;
	Tue, 10 Sep 2002 16:50:45 -0400
Date: Tue, 10 Sep 2002 22:55:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Make filelist for clean and mrproper distributed 0/6
Message-ID: <20020910225530.A17094@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next six mails contains patches to introduce a distributed way
to specify what files to delete during make clean and make mrproper
The end result and the driver for this patch was the possibility
to get rid of the centralised list of files contained in the top-level
makefile.

The patches are split as follows:
1/6	The actual infrastructure added to Rules.make
2/6	makefile for atm updated
3/6	makefile for sound updated
4/6	makefile for various drivers updated
5/6	makefile in scripts/ updated
6/6	Top-level makefile updated, including removal of file-list

	Sam

