Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDIVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDIVqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDIVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:46:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33196 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750803AbWDIVqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:46:03 -0400
Date: Sun, 9 Apr 2006 23:46:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
In-Reply-To: <20060409212548.GA30208@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0604092341130.32445@scrub.home>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
 <20060409212548.GA30208@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Sam Ravnborg wrote:

> With this change when window width is > 80 then we waste half of
> the screen width only to right-indent the menus.

Currently we waste a lot of screen on right side, which is not much 
different. Further there is now a mix of left aligned and centered output, 
which is ugly, so this patch only restores the old behaviour (without the 
jumping around for small text changes).

> We truncate longer prompts and with this we require twice the
> width to see full prompt.

If these longer prompts don't fit into a 80 coloumn window, it's a bug.

bye, Roman
