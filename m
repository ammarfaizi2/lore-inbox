Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCVIiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 03:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCVIiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 03:38:09 -0500
Received: from barclay.balt.net ([195.14.162.78]:56773 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S261804AbUCVIiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 03:38:07 -0500
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <405CC7EC.9030205@gmx.de>
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
	 <405C1B14.6000206@gmx.de> <20040320132334.GB13028@gemtek.lt>
	 <405C979A.8070200@gmx.de>  <405CC7EC.9030205@gmx.de>
Content-Type: text/plain
Organization: Gemtek Baltic
Message-Id: <1079944371.2064.1.camel@swoop.gemtek.lt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 10:32:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you boot without any plugged USB devices and later on plug in USB
devices things are working as expected. Something fishy about hotplug
and perhaps in particular when OHCI and EHCI are initialized with USB
devices connected.

BR 

On Sun, 2004-03-21 at 00:38, Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> 
> > I maybe found something: I compiled "force module unloading" into 
> > kernel, and now it doesn't seem to hang, though I don't understand why 
> > it should make a difference, as nothing is forced. I have to test a bit 
> > more.
> 
> I was wrong, above doesn't work. It still hangs. I don't know how to 
> circumvent it. Something seems to be broken.
> 
> Prakash
> 

