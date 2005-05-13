Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVEMWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVEMWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVEMWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:49:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46539 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262606AbVEMWtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:49:05 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <20050513215905.GY5914@waste.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116024419.20646.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 23:47:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-13 at 22:59, Matt Mackall wrote:
> It might not be much of a problem though. If he's a bit off per guess
> (really impressive), he'll still be many bits off by the time there's
> enough entropy in the primary pool to reseed the secondary pool so he
> can check his guesswork.

You can also disable the tsc to user space in the intel processors.
Thats something they anticipated as being neccessary in secure
environments long ago. This makes the attack much harder.

