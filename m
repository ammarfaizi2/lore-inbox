Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTD2Vf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTD2Vf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:35:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51348
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261864AbTD2Vfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:35:55 -0400
Subject: Re: Crash in vm86() on SMP boxes with vesa driver?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EAE72E8.7176.1E3DFDF8@localhost>
References: <3EAE72E8.7176.1E3DFDF8@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051649372.18198.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 21:49:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-29 at 20:41, Kendall Bennett wrote:
> I will check into this. I am running into some strange problems on an 
> NVIDIA GeForce4 integrated system right now, yet that same BIOS works 
> perfectly in DOS and OS/2 so there is something up with the way the 
> vm86() services are being handled. I will try to solve the problem I am 
> seeing on this NVIDIA machine, and perhaps that will lead to a solution 
> for both problems (assuming they are actually related of course ;-).

Another thing to do is to run it under the emulator x86 stuff in
XFree86, see what that shows up differently to vm86 proper. And then
there are lots of fun things that confuse video hardware - the fact
Linux is a PnP OS, the PCI configuration problems and so on. In 
paticular nobody right now (including X11 proper) virtualises
conf1/conf2 etc properly so you can crash the box easily


