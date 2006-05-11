Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWEKOhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWEKOhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWEKOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:37:11 -0400
Received: from outgoing.securityfocus.com ([205.206.231.27]:13411 "EHLO
	outgoing.securityfocus.com") by vger.kernel.org with ESMTP
	id S1751797AbWEKOhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:37:10 -0400
Date: 11 May 2006 14:34:40 -0000
Message-ID: <20060511143440.23517.qmail@securityfocus.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: "Ed White" <ed.white@libero.it>
To: "ML" <linux-kernel@vger.kernel.org>
Subject: SecurityFocus Article
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A researcher of the french NSA discovered a scary vulnerability in modern x86 cpus and chipsets that expose the kernel to direct tampering.

http://www.securityfocus.com/print/columnists/402

The problem is that a feature called System Management Mode could be used to bypass the kernel and execute code at the highest level possible: ring zero.

The big problem is that the attack is possible thanks to the way X Windows is designed, and so the only way to eradicate it is to redesign it, moving video card driver into the kernel, but it seems that this cannot be done also for missing drivers and documentation!

I would like to hear developers opinion about it...


------------------------------------------------------------------------

The quest for ring 0

by Federico Biancuzzi
2006-05-10

Federico Biancuzzi interviews French researcher Lo&iuml;c Duflot to learn about the System Management Mode attack, how to mitigate it, what hardware is vulnerable, and why we should be concerned with recent X Server bugs.
http://www.securityfocus.com/columnists/402

