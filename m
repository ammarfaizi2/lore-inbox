Return-Path: <linux-kernel-owner+w=401wt.eu-S965136AbXAGUTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbXAGUTk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbXAGUTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:19:40 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18397 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965136AbXAGUTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:19:40 -0500
X-Greylist: delayed 1497 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 15:19:39 EST
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Organization: Dewire
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Date: Sun, 7 Jan 2007 20:58:19 +0100
User-Agent: KMail/1.9.4
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alan <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070107182151.7cc544f3@localhost.localdomain> <20070107191730.GD21133@flint.arm.linux.org.uk>
In-Reply-To: <20070107191730.GD21133@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701072058.20584.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

söndag 07 januari 2007 20:17 skrev Russell King:
[...]
> clearly not UTF-8.  I doubt whether any of the commits I do on my
> en_GB ISO-8859-1 systems end up being UTF-8 encoded.

They don't. Git doesn't convert, with the exception of two mail-related tools, 
which is the reason the commit being discussed ended up as UTF-8
in GIT. The mail containing the patch was in ISO-8859-1. All other git tools 
just store whatever byte sequence they are fed, be ut ISO-latin, utf-8 or 
something (to westeners) more exotic.

-- robin

