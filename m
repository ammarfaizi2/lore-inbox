Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUHOR2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUHOR2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUHOR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:28:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3718 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S264147AbUHOR23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:28:29 -0400
Date: Sun, 15 Aug 2004 19:28:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
In-Reply-To: <20040814074953.GA20123@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0408151925260.12687@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
 <20040814074953.GA20123@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 14 Aug 2004, Sam Ravnborg wrote:

> +void expr_get_dep_txt(struct expr *e, char *t)

What's wrong with expr_print()?

> +	if (menu->sym && menu->sym->dep)
> +		expr_get_dep_txt(menu->sym->dep, t);

The dep field of the symbol isn't used currently (it's left from the 
converter).
Did you already look at the similiar code in qconf.cc?

bye, Roman
