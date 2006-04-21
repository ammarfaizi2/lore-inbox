Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWDUXKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWDUXKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWDUXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:10:23 -0400
Received: from isilmar.linta.de ([213.239.214.66]:50104 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750735AbWDUXKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:10:22 -0400
Date: Sat, 22 Apr 2006 01:10:10 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Subject: [git pull] pcmcia fixes for 2.6.17-rc3
Message-ID: <20060421231010.GA24450@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add lkml to CC, sorry:

----- Forwarded message from Dominik Brodowski -----

Linus, Andrew,

Some PCMCIA fixes for 2.6.17-rc3 can be found at

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/

Please pull from that address.

The diffstat and list of changes follows; the change affecting drivers/net/
received an ACK when I sent out these patches as RFC a couple of days ago.
Also, all these patches were at least in -mm3 and received some testing
there (, I hope).

Thanks,
	Dominik

----
 drivers/net/pcmcia/pcnet_cs.c    |    1 +
 drivers/pcmcia/Kconfig           |    2 +-
 drivers/pcmcia/ds.c              |   16 +++++++---------
 drivers/pcmcia/pcmcia_resource.c |   18 +++++++++++-------
 4 files changed, 20 insertions(+), 17 deletions(-)
----
Andrew Morton:
      pcmcia: remove unneeded forward declarations

Daniel Ritz:
      pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards

Dominik Brodowski:
      pcmcia: add new ID to pcnet_cs
      pcmcia: do not set dev_node to NULL too early
      pcmcia: fix oops in static mapping case

Komuro:
      pcmcia: unload second device first
      pcmcia: fix comment for pcmcia_load_firmware

Yoichi Yuasa:
      vrc4171: update config




----- End forwarded message -----
