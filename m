Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVARTqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVARTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVARTnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:43:39 -0500
Received: from hera.kernel.org ([209.128.68.125]:3821 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261418AbVARTjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:39:17 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Patch to control VGA bus routing and active VGA device.
Date: Tue, 18 Jan 2005 19:38:44 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <csjok4$gn3$1@terminus.zytor.com>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501180946.47026.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106077124 17124 127.0.0.1 (18 Jan 2005 19:38:44 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 18 Jan 2005 19:38:44 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200501180946.47026.jbarnes@engr.sgi.com>
By author:    Jesse Barnes <jbarnes@engr.sgi.com>
In newsgroup: linux.dev.kernel
>
> On Monday, January 17, 2005 7:43 pm, Jon Smirl wrote:
> > Attached is a patch to control VGA bus routing and the active VGA
> > device. It works by adding sysfs attributes to bridge and VGA devices.
> > The bridge attribute is read only and indicates if the bridge is
> > routing VGA. The attribute on the device has four values:
> 
> How is it supposed to work?  Is VGA routing determined by the chipset?  Is it 
> separate from other legacy I/O and memory addresses?
> 

Yes, there are special control bits in any PCI bridge header for the
VGA ports.

	-hpa
