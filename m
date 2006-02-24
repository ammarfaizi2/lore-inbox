Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWBXAO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWBXAO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWBXAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:14:57 -0500
Received: from foo.gazonk.org ([213.212.13.120]:30097 "HELO gazonk.org")
	by vger.kernel.org with SMTP id S932209AbWBXAO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:14:57 -0500
Date: Fri, 24 Feb 2006 01:14:43 +0100 (CET)
From: Jonas Bofjall <jonas@gazonk.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: reiserfs problem with 2.6.15.[234]
Message-ID: <Pine.LNX.4.58.0602240105590.14689@gazonk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix that enables the ReiserFS mount options causes my machine (whose
root filesystem is on reiserfs) to instantly reboot. No idea why, I
suspect some mount option enabled by default causes problems, but other
machines with similar configurations seems unaffected.

I'll take my problem to the reiserfs list, I just wanted to give you an
indication that even that oh-so-simple-bugfix can cause trouble.

Jonas
