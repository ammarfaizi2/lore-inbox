Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVC3Dqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVC3Dqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVC3Dqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:46:30 -0500
Received: from ozlabs.org ([203.10.76.45]:63405 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261751AbVC3DqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:46:21 -0500
Date: Wed, 30 Mar 2005 13:42:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [0/5] Orinoco merge updates, part the fourth
Message-ID: <20050330034238.GF6478@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, please apply:

Here's yet another batch of orinoco updates.  Smaller and less
significant than the last, this is basically a handful of remaining
small updates before tackling the big changes (wext v15, monitor and
scanning).  Patches are:
	orinoco-wstats-updates
		Updates and bugfixes to wireless stats handling
	orinoco-ignore-disconnect
		Add the ignore_disconnect module parameter
	orinoco-kill-dump-recs
		Remove ugly debugging code, to be replaced later with
		simpler and more useful stuff
	orinoco-no-infra-channel
		Don't attempt to set channel in managed mode, the
		firmware doesn't like that.
	orinoco-consolidate-allocate
		Remove some duplicated code for firmware buffer
		allocation, removing a bug in a hw workaround in the
		process.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
