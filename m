Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTKRKgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 05:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKRKgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 05:36:44 -0500
Received: from events-for-love.de ([217.160.111.84]:42438 "EHLO it-people.org")
	by vger.kernel.org with ESMTP id S262328AbTKRKgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 05:36:43 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
To: linux-kernel@vger.kernel.org
Subject: Hard lockup with reiserfs in 2.4.22 an2.4.20
Date: Tue, 18 Nov 2003 11:37:10 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311181137.10908.e.jokisch@u-code.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm not subscribed to the list - please CC me replies.

I experienced hardl lockups and instant reboots with a possibly corrupted 
reiserfs. I didn't find anything like this with goolge so I post it here.

The lockup occures reproduceable when a specific user accesses a file in a 3.6 
reiserfs partition. Even Magic-Sysreq seems to not work. 
The instant reboot happens when I try to copy this users HOME to a different 
location on a different filessystem. 
I'm rather sure that the fs is damaged because I tried reiserfsck  and will 
have to repair with --rebuild-tree.

Please let me know if this error is already known and where to find 
information about it.

If not I will keep the corrupted fs for testing and bugtracking.

Greets
Eckhard Jokisch

