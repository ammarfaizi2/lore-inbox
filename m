Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVBQAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVBQAqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVBQAqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:46:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10379 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262172AbVBQAq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:46:28 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
	dev=/dev/hdX as device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
References: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
	 <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
	 <20050216094221.GA29408@wszip-kinigka.euro.med.ge.com>
	 <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108601093.8377.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Feb 2005 00:44:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-02-16 at 17:36, Valdis.Kletnieks@vt.edu wrote:
> OK, so the problem is that ide-cd is able to *burn* the CD just fine, but it
> suffers lossage when ide-cd tries to read it back...
> 
> Alan - are the sense-byte patches for ide-cd in a shape to push either upstream
> or to -mm?

I think so. They don't solve all reported problems but they do help with
some drives we found problematic in Red Hat internal testing.

