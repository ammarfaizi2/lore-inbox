Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbRDZAIh>; Wed, 25 Apr 2001 20:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133019AbRDZAIS>; Wed, 25 Apr 2001 20:08:18 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:22197 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S133018AbRDZAIO>; Wed, 25 Apr 2001 20:08:14 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200104260007.BAA22627@mauve.demon.co.uk>
Subject: Lid support.
To: linux-kernel@vger.kernel.org
Date: Thu, 26 Apr 2001 01:07:24 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume there is no generic APM support for lid-close?
My BIOS (P100 DEC CTS5100 Hinote VP) has no way to do anything other
than beep, when the lid is closed, so I'm using a hack that polls the
ct65548 video chips registers to find when the BIOS turns the LCD off,
so I can do whatever.

Or is there a better wya?

