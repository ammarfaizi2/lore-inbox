Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVAXR3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVAXR3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAXR3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:29:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47005 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261537AbVAXRZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:25:56 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to control VGA bus routing and active VGA device.
Date: Mon, 24 Jan 2005 09:25:51 -0800
User-Agent: KMail/1.7.1
Cc: "H.Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501181306.03635.jbarnes@engr.sgi.com> <9e473391050122110463d62b5d@mail.gmail.com>
In-Reply-To: <9e473391050122110463d62b5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240925.51988.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, January 22, 2005 11:04 am, Jon Smirl wrote:
> > Well, not all of them, which is why I asked.  Though obviously this patch
> > will need some very platform specific bits at any rate.
>
> What is a case of where the VGA forwarding bit isn't in the bridge
> control? It's part of the PCI spec to have it.

Hmm... lemme check my specs.  It doesn't look like we support that aspect of 
the PCI spec in our bridges.

> We ultimately need both pieces of code, VGA bus routing, and card
> specific VGA enabling code. Even without the card specific code the
> routing code is still useful.

Oh right, doing card specific up/down will allow multiple cards to share the 
same bus, which would be nice.

Jesse
