Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTCBE1l>; Sat, 1 Mar 2003 23:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTCBE1l>; Sat, 1 Mar 2003 23:27:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267476AbTCBE1k>;
	Sat, 1 Mar 2003 23:27:40 -0500
Date: Sun, 2 Mar 2003 04:38:04 +0000
From: Matthew Wilcox <willy@debian.org>
To: Amit Shah <shahamit@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskqueue to workqueue update for riscom8 driver
Message-ID: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, this driver needs to be converted to the new serial core.  It's still
using cli(), for example.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
