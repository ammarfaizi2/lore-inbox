Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVARVGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVARVGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVARVGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:06:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:6316 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261272AbVARVGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:06:05 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "H.Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch to control VGA bus routing and active VGA device.
Date: Tue, 18 Jan 2005 13:06:03 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501180946.47026.jbarnes@engr.sgi.com> <csjok4$gn3$1@terminus.zytor.com>
In-Reply-To: <csjok4$gn3$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501181306.03635.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 18, 2005 11:38 am, H. Peter Anvin wrote:
> > On Monday, January 17, 2005 7:43 pm, Jon Smirl wrote:
> > > Attached is a patch to control VGA bus routing and the active VGA
> > > device. It works by adding sysfs attributes to bridge and VGA devices.
> > > The bridge attribute is read only and indicates if the bridge is
> > > routing VGA. The attribute on the device has four values:
> >
> > How is it supposed to work?  Is VGA routing determined by the chipset? 
> > Is it separate from other legacy I/O and memory addresses?
>
> Yes, there are special control bits in any PCI bridge header for the
> VGA ports.

Well, not all of them, which is why I asked.  Though obviously this patch will 
need some very platform specific bits at any rate.

Jesse
