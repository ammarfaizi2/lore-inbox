Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbTGXOtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270519AbTGXOtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:49:09 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:29432 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S269325AbTGXOtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:49:07 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 15:58:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 13:20, Robert P. J. Day wrote:
>   more to the point, there are drivers that seem to be perpetually
> broken.  as an example, the riscom8 driver has been borked for as 
> long as i can remember.  at some point, shouldn't something like
> this either be fixed or just removed?  what's the point of 
> perpetually bundling a driver that doesn't even compile?

So someone coming from 2.4 can fix it when they need it. You can tag
such things with && OBSOLETE, we did that in 2.4.

