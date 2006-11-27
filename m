Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758366AbWK0Q11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758366AbWK0Q11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758365AbWK0Q11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:27:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63646 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758364AbWK0Q10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:27:26 -0500
Date: Mon, 27 Nov 2006 16:33:28 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061127163328.3f1c12eb@localhost.localdomain>
In-Reply-To: <20061127160144.GB2352@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
	<20061120152505.5d0ba6c5@localhost.localdomain>
	<20061120165601.GS6851@gamma.logic.tuwien.ac.at>
	<20061120172812.64837a0a@localhost.localdomain>
	<20061121115117.GU6851@gamma.logic.tuwien.ac.at>
	<20061121120614.06073ce8@localhost.localdomain>
	<20061122105735.GV6851@gamma.logic.tuwien.ac.at>
	<20061123170557.GY6851@gamma.logic.tuwien.ac.at>
	<20061127130953.GA2352@gamma.logic.tuwien.ac.at>
	<20061127133044.28b8b4ed@localhost.localdomain>
	<20061127160144.GB2352@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What the drive reports as "native" capacity indeed does
> *not* take into (negative-)account those sectors, that have
> been remapped.   So after real remaining capacity has dropped
> below original capacity,  querying the "native" size still
> returns the original size, which is no longer physically
> backed.

This is incorrect.

> I ask for a module/boot-option to allow to skip hpa-checks
> generally, or even for specific drives - to be used, if one
> needs to be sure that these reserved sectors of a connected
> drive are not going to be touched, even when re-partitioning
> the disk.   Afterall that's why they are reserved in the
> first place.

This is a matter for the partitioning tool. You don't know at boot time
what you wish to do with the HPA so a boot option is inappropriate.

Alan
