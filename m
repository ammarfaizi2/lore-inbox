Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDSHzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDSHzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSHzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:55:39 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:36064 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261384AbVDSHzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:55:36 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 19 Apr 2005 09:53:48 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: 2003 John Klar <linpvr@projectplasma.com>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: [2.6 patch] drivers/media/video/tveeprom.c: possible cleanups
Message-ID: <20050419075348.GD15656@bytesex>
References: <20050419005315.GP5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419005315.GP5489@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - #if 0 the EXPORT_SYMBOL'ed but unused function tveeprom_dump

That's a debug helper function, please don't drop it.  #if 0 might be
ok, not sure though, the tveeprom module is also used by a out-of-kernel
driver (ivtv).  Otherwise the patch looks fine to me.

  Gerd

