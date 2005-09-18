Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVIRJMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVIRJMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIRJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 05:12:46 -0400
Received: from mail.enyo.de ([212.9.189.167]:45467 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750723AbVIRJMp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 05:12:45 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: CAN-2001-1551
Date: Sun, 18 Sep 2005 11:12:37 +0200
Message-ID: <874q8ig2nu.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has this issue been fixed?  Or is this not a kernel bug?

| From: Wojciech Purczyñski (wpsupermedia.pl)
| Date: Mon Oct 22 2001 - 03:43:13 CDT
| 
| Almost any suid binary may be used to create large files overriding quota
| limits.
| 
| When setuid-root binary inherits file descriptors from user process it may
| write to it without respecting the quota restrictions. This is because
| suid process has CAP_SYS_RESOURCE effective capability enabled during
| writing to the file. Quota does not know anything about who opened file
| descriptor and checks current process privileges only. This is bug in
| kernel and not in those setuid-root binaries. 

<http://archives.neohapsis.com/archives/bugtraq/2001-10/0179.html>
