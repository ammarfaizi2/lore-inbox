Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbUCZM6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUCZM6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:58:51 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:45384 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S264035AbUCZM6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:58:50 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200403261258.i2QCwmWP023039@green.mif.pg.gda.pl>
Subject: Re: [2.4] disapearing routing entries
To: ahu@ds9a.nl (bert hubert)
Date: Fri, 26 Mar 2004 13:58:48 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20040326120236.GB22185@outpost.ds9a.nl> from "bert hubert" at Mar 26, 2004 01:02:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Fri, Mar 26, 2004 at 11:33:42AM +0100, Andrzej Krzysztofowicz wrote:
> > Hi,
> > 
> > I sometimes notice while using different 2.4/2.2 kernels that some static
> > route entries tend to disappear suddenly few days after they are manually
> > added. It happens only to manually added (non-automatic) entries.
> > No messages concerning this are found in dmesg and system logs.
> 
> Make doubly sure you are not running routed, gated or zebra/quagga,
> userspace tools which change your routing.

None of them.
Only apache and openvpn on one machine and only dhcpd on another one.

The disappearing entries were not related to openvpn routing.

( disapear: route to a specific host via a specific gw and defaultroute
  in an extra routing table )

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
