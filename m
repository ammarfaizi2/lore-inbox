Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937625AbWLFU2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937625AbWLFU2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937624AbWLFU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:28:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:10376 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937619AbWLFU2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:28:20 -0500
Date: Wed, 6 Dec 2006 12:28:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
Message-Id: <20061206122830.1c5fda5b.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 15:10:44 +0000 (GMT) James Simmons wrote:

> 
> > > of Mr. Yu for acpi. Also this class could in time replace the lcd class 
> > > located in the backlight directory since a lcd is a type of display.
> > > The final hope is that the purpose auxdisplay could fall under this 
> > > catergory.
> > > 
> > > P.S
> > >    I know the edid parsing would have to be pulled out of the fbdev layer.
> 
> That patch was rought draft for feedback. I applied your comments. This 
> patch actually works. It includes my backlight fix as well.

BTW, this patch version contains trailing whitespace
which should be cleaned up:

Warning: trailing whitespace in lines 33,158 of drivers/acpi/video.c
Warning: trailing whitespace in line 10 of drivers/video/display/Kconfig
Warning: trailing whitespace in line 41 of include/linux/display.h
Warning: trailing whitespace in lines 49,1053,1084,1133 of drivers/video/Kconfig
Warning: trailing whitespace in line 3 of drivers/video/display/Makefile

---
~Randy
