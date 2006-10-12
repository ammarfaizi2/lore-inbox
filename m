Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161531AbWJLJvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161531AbWJLJvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 05:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161536AbWJLJvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 05:51:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53125 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161533AbWJLJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 05:51:53 -0400
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1160618642.6596.27.camel@lade.trondhjem.org>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
	 <1160616905.6596.14.camel@lade.trondhjem.org>
	 <20061012015306.GB27693@lists.us.dell.com>
	 <1160618642.6596.27.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 11:16:57 +0100
Message-Id: <1160648217.23731.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-11 am 19:04 -0700, ysgrifennodd Trond Myklebust:
> The daemon solution also fails to provide any guarantees on a NFSROOT
> setup.

You know the ports that will be used at NFSroot setup time and they
won't currently get near the broken box problem ports. Also NFS root is
pretty much obsoleted by the initrd/pivot_root stuff.


Alan

