Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVH3OLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVH3OLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVH3OLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:11:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:62371 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932146AbVH3OLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:11:32 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292207330.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
	 <9e473391050829215148807c49@mail.gmail.com>
	 <Pine.LNX.4.58.0508292207330.3243@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 15:39:18 +0100
Message-Id: <1125412758.8276.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-29 at 22:15 -0700, Linus Torvalds wrote:
> I'm sure X plays games with this register (I suspect that's why the Matrox 
> thing broke in the first place), but I don't think it should do so while 
> the kernel uses it. 

X maps it over ram during matrox set up but that is all it uses it for.
X can also be persuaded to do it differently given a suitable kernel
API.
