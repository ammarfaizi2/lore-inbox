Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVACQ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVACQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVACQ44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:56:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27056 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261499AbVACQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:56:52 -0500
Subject: Re: [PATCH] disallow modular capabilities
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050103003237.GA89490@muc.de>
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de>
	 <20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de>
	 <20050102223650.GA5818@localhost> <20050102233039.GB71343@muc.de>
	 <20050103002102.GA5987@localhost>  <20050103003237.GA89490@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104766076.12780.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 15:52:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-03 at 00:32, Andi Kleen wrote:
> You just have to be careful to not start any daemons before it,
> safest is probably to load it in the initrd.

In which case a documentation patch is needed and maybe some __init code
at boot which checks whether it can safely insert and errors if not

