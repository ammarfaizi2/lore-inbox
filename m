Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTE0Vf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTE0Vf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:35:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15567
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264080AbTE0Vf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:35:57 -0400
Subject: Re: [patch] sis650 irq router fix for 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Davide Libenzi <davidel@xmailserver.org>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3ED3CDA9.5090605@winischhofer.net>
References: <3ED21CE3.9060400@winischhofer.net>
	 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
	 <3ED32BA4.4040707@winischhofer.net>
	 <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
	 <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>
	 <3ED3CDA9.5090605@winischhofer.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054068660.19108.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 21:51:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-27 at 21:42, Thomas Winischhofer wrote:
> Alan Cox wrote:
> > I'm keeping an eye on it. The correct answer appears to be 
> > "use ACPI" once it works on SiS
> 
> It already does. No problem, except for idiotic OS string checks which 
> require using a custom DSDT.

It only works for setups that choose not to use the APIC in the ACPI
setup. I know how to fix it (indeed I fixed 2.5 ages ago with info from
Ollie)


