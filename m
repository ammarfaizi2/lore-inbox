Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVAFPkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVAFPkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVAFPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:38:33 -0500
Received: from dialin-145-254-059-248.arcor-ip.net ([145.254.59.248]:25092
	"EHLO spit.home") by vger.kernel.org with ESMTP id S262888AbVAFPgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:36:40 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kconfig: avoid temporary file
Date: Thu, 6 Jan 2005 15:53:10 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <200501051340.31794.zippel@linux-m68k.org> <20050105181402.GA15675@mars.ravnborg.org>
In-Reply-To: <20050105181402.GA15675@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061553.11247.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 05 January 2005 19:14, Sam Ravnborg wrote:

> > - it didn't resize when the terminal changed.
>
> Resize support will not be added until it works.

Well, please keep it mind. I don't want to lose this feature, because you had 
to rewrite everything once again.

> > - window layering, old windows are not removed and just drawn over (this
> > was especially a problem with help texts).
>
> Did not see it as a problem as such - will try to play with it a bit
> more. I have the original patch more or less blindly applied. For an
> acceptable version a parts of it will be redone.

Try to select help from an input or choice dialog - it's ugly.
The current interface expects that only a single dialog window is visible at a 
time, maybe it's better to keep this behaviour for the first version, do some 
cleanups and add new features later.

> I also noticed that ESC was not working as usual.

Yes, now I remember that one too, but it's already some time ago, I tested 
this. :)

bye, Roman
