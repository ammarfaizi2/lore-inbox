Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVAKVXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVAKVXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVAKVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:21:33 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:14266 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262743AbVAKVVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:21:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Date: Tue, 11 Jan 2005 22:20:52 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112220.53011.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.6.10-mm2, if swsusp suspends my box on AC power and then it's resumed on 
batteries, the box reboots after (or while) suspending devices (ie before 
restoring the image).  This is 100% reproducible, it appears.

The box is an Athlon 64 laptop on NForce 3.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
