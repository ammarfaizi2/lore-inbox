Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUHOWtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUHOWtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUHOWtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:49:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38023 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267209AbUHOWtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:49:39 -0400
Date: Mon, 16 Aug 2004 00:49:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
In-Reply-To: <20040815175858.GC7265@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0408160047280.12687@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
 <20040814074953.GA20123@mars.ravnborg.org> <Pine.LNX.4.61.0408151925260.12687@scrub.home>
 <20040815175858.GC7265@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Aug 2004, Sam Ravnborg wrote:

> > What's wrong with expr_print()?
> Nothing ;-)
> Originally I had in mind expanding string storage using realloc as required.
> But my hack became a bit simpler than that, so I could have used it.

I already thought about changing the argument to expr_print into a 
structure to e.g. add another function to get more control about how to 
print a symbol, do realloc would be easier then as well.

bye, Roman
