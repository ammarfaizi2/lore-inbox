Return-Path: <linux-kernel-owner+w=401wt.eu-S932529AbXAGNGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbXAGNGx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXAGNGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:06:53 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55235 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932529AbXAGNGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:06:52 -0500
X-Sasl-enc: xNXhhtTUBf28qphHXTqyIHWOb7Nb+ZsEyNjwFbMwT7ZN 1168175019
Message-ID: <45A0F060.9090207@imap.cc>
Date: Sun, 07 Jan 2007 14:06:40 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OT: character encodings (was: Linux 2.6.20-rc4)
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk>
In-Reply-To: <20070107114439.GC21613@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King schrieb:
[Leonard NorrgÃ¥rd (1):]
> That is an å if you look at the raw message in UTF-8.  However, Linus
> sends mail in with a charset of ISO-8859-1, and if you place UTF-8
> encoded text in such a message body, you will see A¥.

Only if the mechanism used for placing it there ignores the different
encodings.

> Welcome to the mess which the UTF-8 charset creates.

The problem of different character encodings coexisting on the same
platform, and the resulting occasional messing-up, far predates Unicode.
I distinctly remember one case of being bitten by this myself in 1977
when Unicode wasn't even on the horizon yet, and I don't think that was
the first time.

Tilman

