Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSIRQCR>; Wed, 18 Sep 2002 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbSIRQCR>; Wed, 18 Sep 2002 12:02:17 -0400
Received: from dmz.hesby.net ([81.29.32.2]:57267 "HELO firewall.hesbynett.no")
	by vger.kernel.org with SMTP id <S267107AbSIRQCQ> convert rfc822-to-8bit;
	Wed, 18 Sep 2002 12:02:16 -0400
Subject: Re: Virtual to physical address mapping
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D8867E7.4010107@quark.didntduck.org>
References: <1032328456.5812.16.camel@zole.jblinux.net> 
	<3D8867E7.4010107@quark.didntduck.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 18:10:54 +0200
Message-Id: <1032365454.3485.20.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 13:47, Brian Gerst wrote:
> Ole André Vadla Ravnås wrote:
> > Hi
> > 
> > I've noticed that ifconfig shows a base address and an interrupt
> > number.. However, I can't get that base address to correspond to
> > anything in /proc/iomem, which means that I can't determine which PCI
> > device (in this case) it corresponds to (guess the base address is
> > virtual). What I want is to find a way to get the PCI bus and device no
> > for the network device, but is this at all possible without altering the
> > kernel?
> > 
> > Ole André
> 
> It's in /proc/ioports

Well, yes you're absolutely right, I got that all wrong in the first
place. Fortunately things are clearing up now.. :-) Thanks

Best regards
Ole André


