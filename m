Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVAJS12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVAJS12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVAJSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:25:58 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10691 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262406AbVAJSHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:07:11 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] PCI rom.c cleanups
Date: Mon, 10 Jan 2005 10:06:56 -0800
User-Agent: KMail/1.7.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
References: <200501091530.47556.jbarnes@sgi.com> <9e47339105010919284cb0d5c3@mail.gmail.com>
In-Reply-To: <9e47339105010919284cb0d5c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101006.56790.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 9, 2005 7:28 pm, Jon Smirl wrote:
> Looks fine to me.
>
> I sent out another clean patch here:
> http://lkml.org/lkml/2005/1/7/274

Yeah, I saw that, it looks good.  Converting drivers to use pci_map/unmap_rom 
is pretty easy, so we should even be able to get rid of most of the 
PCI_ROM_ENABLE stuff eventually.

Jesse
