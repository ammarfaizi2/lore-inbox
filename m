Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVACTZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVACTZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVACTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:25:04 -0500
Received: from relay.axxeo.de ([213.239.199.237]:22711 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261682AbVACTYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:24:36 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kconfig: help includes dependency information
Date: Mon, 3 Jan 2005 20:24:26 +0100
User-Agent: KMail/1.6.2
References: <20041230235146.GA9450@mars.ravnborg.org> <200501010502.55612.ioe-lkml@axxeo.de> <20050102201600.GA9900@mars.ravnborg.org>
In-Reply-To: <20050102201600.GA9900@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501032024.26733.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
hi Roman,

Sam Ravnborg schrieb:
> > Using the verbose config information and linking to their help texts
> > would make it even more user friendly in my opinion.
>
> verbose config option - please explain what you have in mind here.

Example from drivers/char/Kconfig:

SERIAL_NONSTANDARD - the config option
"Non-standard serial port support" - the verbose config option

please present the latter to the user, if not done already.

> > "depends on:" is not really needed, since you usually cannot select any
> > option, where you didn't fulfill the dependencies, AFAICS.
>
> It is sometimes usefull to see what a specific config option is dependent
> of. But you are right that it is not visible in menuconfig (today) when
> "depends on" is not satisfied.

Yes, I've been told later, that you see that in xconfig. I only
use either menuconfig or oldconfig, so I've never seen that before ;-)

Regards

Ingo Oeser

