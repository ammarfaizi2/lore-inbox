Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVCTMuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVCTMuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVCTMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 07:50:18 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:53004 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262159AbVCTMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 07:50:14 -0500
Message-Id: <200503201250.j2KCoAq11871@blake.inputplus.co.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree() in security/ 
In-Reply-To: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost> 
Date: Sun, 20 Mar 2005 12:50:10 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,

> kfree() handles NULL pointers, so checking a pointer for NULL before 
> calling kfree() on it is pointless.

Not necessarily.  It helps tell the reader that the pointer may be NULL
at that point.  This has come up before.

    http://groups-beta.google.com/group/linux.kernel/browse_thread/thread/bd3d6e5a29e43c73/7b43819f874295e8?q=ralph@inputplus.co.uk+persuade+lkml#7b43819f874295e8

Cheers,


Ralph.

