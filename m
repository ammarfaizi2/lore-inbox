Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUADPDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265711AbUADPDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:03:38 -0500
Received: from [130.57.169.10] ([130.57.169.10]:26040 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265710AbUADPDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:03:36 -0500
Subject: Re: Pentium M config option for 2.6
From: Rob Love <rml@ximian.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: szepe@pinerecords.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200401041227.i04CReNI004912@harpo.it.uu.se>
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1073228608.2717.39.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 04 Jan 2004 10:03:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 07:27, Mikael Pettersson wrote:


> And since P-M doesn't do SMP, does cache line size even
> matter? There are no locks to protect from ping-ponging.

Cache line size does still come into the picture on UP, albeit not as
much as with SMP - but e.g. it still matters to things like device
drivers doing DMA.

	Rob Love


