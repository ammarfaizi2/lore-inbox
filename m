Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWHAPLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWHAPLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWHAPLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:11:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52962 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750780AbWHAPLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:11:18 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
References: <200607312314.37863.bernd-schubert@gmx.de>
	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 16:29:49 +0100
Message-Id: <1154446189.15540.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 16:52 +0200, ysgrifennodd Adrian Ulrich:
> WriteCache, Mirroring between 2 Datacenters, snapshotting.. etc..
> you don't need your filesystem beeing super-robust against bad sectors
> and such stuff because:

You do it turns out. Its becoming an issue more and more that the sheer
amount of storage means that the undetected error rate from disks,
hosts, memory, cables and everything else is rising.

There has been a great deal of discussion about this at the filesystem
and kernel summits - and data is getting kicked the way of networking -
end to end not reliability in the middle.

The sort of changes this needs hit the block layer and ever fs.

