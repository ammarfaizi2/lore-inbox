Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTI2KU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTI2KU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:20:28 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:19616 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S262993AbTI2KU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:20:26 -0400
Date: Mon, 29 Sep 2003 20:20:22 +1000
From: david@luyer.net
To: linux-kernel@vger.kernel.org
Subject: Cosmetic error: 2.4.20 bootup and >2^31 sector SCSI devices
Message-ID: <20030929102022.GB14176@pacific.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like it's using some signed numbers that should be unsigned:

SCSI device sdc: -876998784 512-byte hdwr sectors (-449022 MB)

However all the tools (mkfs etc) work correctly and work out the correct
drive size (~1.75Tb):

/dev/sdc              1.7T  465G  1.2T  27% /usr/local/netflow/data

Apologies if it's already fixed in later 2.4.x.

David.
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Network Development Manager    P A C I F I C    Fax:     +61 3 9698 4825
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                      NASDAQ:  PCNTF
