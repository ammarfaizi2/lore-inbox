Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbULTPz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbULTPz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbULTPz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:55:26 -0500
Received: from bristol.swissdisk.com ([65.207.35.130]:37596 "EHLO
	bristol.swissdisk.com") by vger.kernel.org with ESMTP
	id S261540AbULTPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:55:16 -0500
Date: Mon, 20 Dec 2004 09:39:01 -0500
From: Ben Collins <bcollins@debian.org>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220143901.GD457@phunnypharm.org>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C694E0.8010609@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about adding those exports into an config option ifdef that says
"Export extra IEEE-1394 symbols" and in the help explains that the symbols
may be needed for some third party modules. Give video-2-1394 as an
example.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
