Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWETPgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWETPgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWETPgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:36:43 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:62600 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751092AbWETPgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:36:43 -0400
Message-ID: <446F3788.8050105@drzeus.cx>
Date: Sat, 20 May 2006 17:36:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ppisa4lists@pikron.com,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Was this really supposed to go in?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2c171bf13423dc5293188cea7f6c2da1720926e2 in Linus' tree seems
strange. It includes more changes than Pavel's original patch, but with
the same commit message. Also, I think the extra changes are broken as
we then would have two parameters that have that contain the same
information, yet the do not have the same ranges.

gitweb of the commit:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2c171bf13423dc5293188cea7f6c2da1720926e2

Rgds
Pierre
