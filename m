Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTJZUGz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTJZUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 15:06:55 -0500
Received: from imap.gmx.net ([213.165.64.20]:43983 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263638AbTJZUGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 15:06:48 -0500
X-Authenticated: #20450766
Date: Sun, 26 Oct 2003 20:27:40 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NLS as module
In-Reply-To: <87wuas9ejy.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0310262026140.3346-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, OGAWA Hirofumi wrote:

> "Randy.Dunlap" <rddunlap@osdl.org> writes:
>
> > I would prefer to see the opposite:  selecting an FS that requires NLS
> > should force NLS to be enabled, via "select NLS".
>
> Yes, sure. The following include it fix.
>
>  - use "select" instead of "depend"
>  - remove the unused SMB_NLS
>  - remove unneeded "default y" of CONFIG_NLS
>  - revert to postion of nls menu (middle of filessytem menus is strange)
>  - fix "#ifdef CONFIG_NLS" on UDF (should this add new one to Kconfig?)

Sure. Looks much better.

Guennadi
---
Guennadi Liakhovetski


