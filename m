Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUGMRpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUGMRpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 13:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUGMRpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 13:45:42 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:24874 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265684AbUGMRpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 13:45:41 -0400
Date: Tue, 13 Jul 2004 12:45:40 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org, misc@openbsd.org,
       nbd-general@lists.sourceforge.net
Subject: [ANNOUNCE] Portable NBD server
Message-ID: <20040713174540.GA727@hexapodia.org>
Reply-To: nbd-general@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the cross-post, but this is relevant to all three lists.
Please don't cross-post followups (unless they're relevant to several
lists); obey the Reply-To or reply to me directly.

The NBD server in nbd-2.7.1 from nbd.sourceforge.net doesn't compile on
non-Linux hosts, even though the server doesn't do anything inherently
nonportable.  So I wrote a new one that should work fine on any POSIX
host with 'long long'.

I've successfully used it to recover log data on a dirty ext3 filesystem
that ended up in an OpenBSD box.

I hope this proves useful to someone.

http://web.hexapodia.org/~adi/nbd/nbdsvr-0.1.tar.gz
http://web.hexapodia.org/~adi/nbd/

-andy
