Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbUJ2WrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUJ2WrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbUJ2Wnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:43:32 -0400
Received: from donobi-8-7.ra.donobi.net ([64.113.8.7]:129 "EHLO
	honcho.homelinux.net") by vger.kernel.org with ESMTP
	id S262603AbUJ2Wdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:33:32 -0400
Date: Fri, 29 Oct 2004 22:33:20 +0000
From: Glen Journeay <journeay@silverlink.net>
Subject: Problems with less/man - kernel 2.6.9+
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.5
Message-Id: <1099089200l.3205l.1l@honcho>
X-Balsa-Fcc: file:///home/glen/mail/sent-mail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I begin having problems with less and man starting with 2.6.9.

I noticed some posts on the kernel list complaining of ssh failures
which were caused by using legacy ptys.  I changed this in config:

CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

(linux-2.6.8.1)

to this

CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

(linux-2.6.10-rc1)

and less/man is back to running.


Glen


Get out the vote!


