Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbULOWJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbULOWJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbULOWJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:09:43 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:50461 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262512AbULOWJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:09:42 -0500
To: "mike mike" <listsub@hotmail.com>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <BAY22-F10C3E172FBB1C6E1585178A9AD0@phx.gbl>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 15 Dec 2004 14:09:21 -0800
In-Reply-To: <BAY22-F10C3E172FBB1C6E1585178A9AD0@phx.gbl> (mike mike's
 message of "Wed, 15 Dec 2004 15:36:37 -0600")
Message-ID: <527jnjusby.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: 2g/2g split
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Dec 2004 22:09:22.0210 (UTC) FILETIME=[BB182020:01C4E2F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest 2.6 tree, all you need to do to get a 2g/2g split is
change the two definitions of __PAGE_OFFSET in asm-i386/page.h from
0xC0000000 to 0x80000000.

 - Roland
