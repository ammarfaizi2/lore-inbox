Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWBZMlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWBZMlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBZMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:41:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45269 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751080AbWBZMll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:41:41 -0500
Subject: Re: RTL 8139 stops RX after receiving a jumbo frame
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Zielinski <john_ml@undead.cc>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <44012D53.30700@undead.cc>
References: <44012D53.30700@undead.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Feb 2006 12:46:05 +0000
Message-Id: <1140957965.23286.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-02-25 at 23:23 -0500, John Zielinski wrote:
> I'm surprised that the switch actually let the jumbo packet through onto 
> a 100Mbit link.  I'm going to see if I can find a non RTL 8139 card in 
> my parts bin and see what that one does.
> 
> What's the normal behavior for overruns on an interface?

Should drop the packet, but it may be triggering a driver path with a
bug. Is this repeatable and with multiple 8139 cards /

