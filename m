Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVKCXdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVKCXdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbVKCXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:33:39 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23501 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030530AbVKCXdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:33:38 -0500
Date: Fri, 4 Nov 2005 00:33:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] kconfig: update kconfig Makefile
In-Reply-To: <20051103230647.GA7722@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0511040032110.12843@scrub.home>
References: <Pine.LNX.4.61.0511031607490.2509@scrub.home>
 <20051103230647.GA7722@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Nov 2005, Sam Ravnborg wrote:

> Hi Roman.
> 
> > -$(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
> > -$(obj)/lex.zconf.c: $(src)/lex.zconf.c_shipped
> They were required to support building with a seperate output directory.
> 
> make O=...
> And I do not see any changes that fixes this.

It works fine here without it?

bye, Roman
