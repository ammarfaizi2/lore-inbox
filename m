Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUEGLNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUEGLNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUEGLNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:13:22 -0400
Received: from ee.oulu.fi ([130.231.61.23]:63694 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263183AbUEGLNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:13:21 -0400
Date: Fri, 7 May 2004 14:12:36 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Pekka Pietikainen <pp@netppl.fi>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] b44 ethtool_ops
Message-ID: <20040507111236.GA29330@ee.oulu.fi>
References: <4097FADB.4090105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4097FADB.4090105@pobox.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 04:19:39PM -0400, Jeff Garzik wrote:
> Testing requested.
> 
> Should see no ethtool behavior change, positive or negative.
Well, driver still works, advertised link modes does look a bit odd though
(ethtool-1.8-3.1)

Settings for eth1:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
        Supports auto-negotiation: Yes
        Advertised link modes:  1000baseT/Full 
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x000000ff (255)
        Link detected: yes

