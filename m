Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEYE74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTEYE74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:59:56 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:64896
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261411AbTEYE7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:59:55 -0400
Date: Sun, 25 May 2003 01:03:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Valdis.Kletnieks@vt.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: <200305250448.h4P4mqoH005720@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.50.0305250102130.17353-100000@montezuma.mastecende.com>
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
 <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>           
 <Pine.LNX.4.50.0305242335090.17353-100000@montezuma.mastecende.com>
 <200305250448.h4P4mqoH005720@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 24 May 2003 23:36:26 EDT, Zwane Mwaikambo said:
> 
> > > Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
> 
> > It's known broken with that configuration and hence blacklisted.
> 
> Yes, I know it's blacklisted.  The question I intended to ask was "Is the
> entire concept of IOAPIC irretrievably scrozzled on this machine, or is there
> sufficient minimum functionality to get nmi_watchdog working?"

You don't have an IOAPIC at all, but the Local APIC has been known to 
cause problems. So forget about nmi_watchdog.

	Zwane
-- 
function.linuxpower.ca
