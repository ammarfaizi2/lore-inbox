Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268776AbTCCUpy>; Mon, 3 Mar 2003 15:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268791AbTCCUpy>; Mon, 3 Mar 2003 15:45:54 -0500
Received: from a.smtp-out.sonic.net ([208.201.224.38]:29859 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S268776AbTCCUpx>; Mon, 3 Mar 2003 15:45:53 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Mon, 3 Mar 2003 12:56:20 -0800
From: David Hinds <dhinds@sonic.net>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
Message-ID: <20030303125620.A26220@sonic.net>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com> <20030301093814.A6700@sonic.net> <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 12:26:54PM -0500, Pavel Roskin wrote:
> 
> I'm not aware of the "political" situation around PCMCIA drivers, but I
> think it's sad that the kernel drivers are pushed (e.g. by Red Hat) in the
> hope that they will get more visibility and will be improved, but the
> people who have the best expertize still use pcmcia-cs drivers and work on
> improving them.

I don't think it is a political issue.  I think the kernel drivers
should be promoted and I've encourated other distributions to go that
route as well.  And I hope that this leads to better drivers.  I do
maintenance work on the pcmcia-cs drivers but don't intend to add any
new functionality.

I've tried to update the kernel tree with fixes from individual PCMCIA
client drivers in the pcmcia-cs package.  The divergence of the core
modules is pretty large, though, so it is not a simple "diff", and I
know I've missed things.

I do not have time to be a more active maintainer these days, either
of pcmcia-cs or of the kernel PCMCIA drivers.

> I think it CONFIG_ISA is meant to be that.  The "ISA support" is so
> trivial from the kernel perspective, that the line between systems with
> and without ISA is somewhat blurred.

I don't really know what the scope of CONFIG_ISA should be.  I think
now it is mainly used to show or hide drivers for ISA cards, rather
than describing a system capability.

-- Dave
