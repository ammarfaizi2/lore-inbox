Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUEXK1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUEXK1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUEXK1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:27:07 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:57900
	"EHLO chancellorcare.co.uk") by vger.kernel.org with ESMTP
	id S264238AbUEXK1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:27:04 -0400
thread-index: AcRBeajVj/5QmQTVRmehh9iUT9Llig==
X-Sieve: Server Sieve 2.2
Date: Mon, 24 May 2004 11:27:05 +0100
From: "Colin Leroy" <colin@colino.net>
To: <Sumlock@vger.kernel.org>
Message-ID: <000e01c44179$a8d5d210$0100000a@chancellor.local>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.6.6-bk9, quick test
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
Content-Class: urn:content-classes:message
X-Loop: linuxppc-dev@lists.linuxppc.org
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
X-me-spamrating: 1.601005
X-OriginalArrivalTime: 24 May 2004 10:27:05.0781 (UTC) FILETIME=[A9248E50:01C44179]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi people,

I gave a shot at linux 2.6.6-bk9 on PPC32 (ibook G4) today, noticed two
problems. First, pbbuttonsd complains about /dev/adb missing and indeed,
it isn't there. Looks like related to Ben's changes to
drivers/macintosh/adb.c, but maybe due to some devfs (I know, outdated
;-)) configuration problem?

Second problem, tried to mount an usb key, and it failed: mount hung.
(ehci driver).

I didn't have time to investigate this stuff, but thought it could help
to mention it ?

Thanks,
--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


