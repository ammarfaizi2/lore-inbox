Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUKSCnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUKSCnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUKSCla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:41:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:32133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261236AbUKSCaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:30:02 -0500
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CUxDU-0000XP-00@penngrove.fdns.net>
References: <E1CUxDU-0000XP-00@penngrove.fdns.net>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 13:26:29 +1100
Message-Id: <1100831189.25497.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 17:05 -0800, John Mock wrote:

> 
> If you might be so kind as to tell me which function and/or file that the
> video mode is being resynthesized in, then i can probably come with some
> kind of work-around.  Then you can feel like you can fix this issue when
> it's convenient to do so.  I looked for this once before but bogged down
> before i got anywhere.

drivers/video/controlfb, function is controlfb_set_par()

Ben.


