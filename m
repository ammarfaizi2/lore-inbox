Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUBPMHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 07:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUBPMHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 07:07:34 -0500
Received: from web12901.mail.yahoo.com ([216.136.174.68]:50439 "HELO
	web12901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262580AbUBPMHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 07:07:32 -0500
Message-ID: <20040216120731.13715.qmail@web12901.mail.yahoo.com>
Date: Mon, 16 Feb 2004 04:07:31 -0800 (PST)
From: Michael Grimborounis <mgrimbor@yahoo.com>
Subject: INSTALL_PATH question: Makefile bug?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding the way INSTALL_PATH is set up in the top
level Makefile. I can pass a value or uncomment it, like the comments
in the makefile suggest. But then if INSTALL_MOD_PATH is undefined,
INSTALL_PATH is unset by the following statements:


ifndef INSTALL_MOD_PATH
INSTALL_PATH=
endif
export INSTALL_MOD_PATH


It seems that if I don't define INSTALL_MOD_PATH, there is no way for
me to pass a path for the kernel and map images. Is this the intended
behaviour or is it a bug? Should that have been "INSTALL_MOD_PATH="?


__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
