Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVAAED2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVAAED2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAAED2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:03:28 -0500
Received: from relay.axxeo.de ([213.239.199.237]:46004 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262188AbVAAEDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:03:07 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kconfig: help includes dependency information
Date: Sat, 1 Jan 2005 05:02:55 +0100
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>
References: <20041230235146.GA9450@mars.ravnborg.org> <20041230235309.GD9450@mars.ravnborg.org>
In-Reply-To: <20041230235309.GD9450@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501010502.55612.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, 

nice to have this information available now.

Sam Ravnborg wrote:
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/12/31 00:43:45+01:00 sam@mars.ravnborg.org
> #   kconfig: help includes dependency information
> #
> #   When selecting help on a menu item display
> #   "depends on:"
> #   "selects:"
> #   "selected by:"
> #
> #   Only relevant headlines are displayed - so if no "selects:" appear then
> this menu #   does not select a specific symbol.
> #   Loosly based on a patch by: Cal Peake <cp@absolutedigital.net>

I would prefer this information at the END of the help text,
since it is actually most useful to developers and more advanced users 
and thus equals in value to the old notice how a module is called.

If I call for help, I usually like to know WHAT it is and then WHY I might
need it.

Using the verbose config information and linking to their help texts would 
make it even more user friendly in my opinion.

"depends on:" is not really needed, since you usually cannot select any 
option, where you didn't fulfill the dependencies, AFAICS.


Regards

Ingo Oeser

