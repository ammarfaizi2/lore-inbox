Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUC0Qqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 11:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUC0Qqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 11:46:42 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:31059 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261822AbUC0Qqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 11:46:40 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200403271646.i2RGkdLq009900@green.mif.pg.gda.pl>
Subject: Re: [2.4] disapearing routing entries
To: jamie@shareable.org (Jamie Lokier)
Date: Sat, 27 Mar 2004 17:46:39 +0100 (CET)
Cc: ahu@ds9a.nl (bert hubert), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20040327140002.GE21884@mail.shareable.org> from "Jamie Lokier" at Mar 27, 2004 02:00:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Andrzej Krzysztofowicz wrote:
> > None of them.
> > Only apache and openvpn on one machine and only dhcpd on another one.
> 
> Are you running a DHCP client (dhclient, pump, dhcpcd or any other) on
> the first machine?

Yes, I do. I didn't think it may be the source of the problem as DHCP
timings are:
  LEASETIME=7200
  RENEWALTIME=3600
  REBINDTIME=6300
and the problem appears after a week or more of normal operation.
But I will disable dhcpcd and test again.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
