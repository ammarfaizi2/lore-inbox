Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135292AbRDRUJz>; Wed, 18 Apr 2001 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135288AbRDRUJe>; Wed, 18 Apr 2001 16:09:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135284AbRDRUJW>; Wed, 18 Apr 2001 16:09:22 -0400
Subject: Re: Let init know user wants to shutdown
To: chief@bandits.org (John Fremlin)
Date: Wed, 18 Apr 2001 21:10:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sfr@linuxcare.com.au,
        linux-kernel@vger.kernel.org, apenwarr@worldvisions.ca
In-Reply-To: <m27l0i58i3.fsf@boreas.yi.org.> from "John Fremlin" at Apr 18, 2001 08:10:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pyHg-0005cJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> willing to exercise this power. We would not break compatibility with
> any std kernel by instead having a apmd send a "reject all" ioctl
> instead, and so deal with events without having the pressure of having
> to reject or accept them, and let us remove all the veto code from the
> kernel driver. Or am I missing something?

That sounds workable. But the same program could reply to the events just
as well as issue the ioctl 8)


