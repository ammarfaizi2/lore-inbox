Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVEaJ1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVEaJ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVEaJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:27:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4749 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261276AbVEaJ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:27:23 -0400
Date: Tue, 31 May 2005 11:27:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: blaisorblade@yahoo.it
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] kconfig: trivial cleanup
In-Reply-To: <20050529174525.A36D7A2FA3@zion.home.lan>
Message-ID: <Pine.LNX.4.61.0505311123310.3728@scrub.home>
References: <20050529174525.A36D7A2FA3@zion.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 29 May 2005 blaisorblade@yahoo.it wrote:

> If you want, I'll do one patch update the included version to 2.0 Bison (which
> uses an updated skeleton) and then, separately, a patch updating
> zconf.tab.c_shipped to reflect the updated zconf.y.

I'd prefer to patch the changes into zconf.tab.c_shipped directly. At some 
point it should be regenerated, but I'd like to avoid it and only do it if 
the parser itself needs a change.

bye, Roman
