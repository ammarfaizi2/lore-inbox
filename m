Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbTAMThc>; Mon, 13 Jan 2003 14:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268306AbTAMThc>; Mon, 13 Jan 2003 14:37:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59743 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268308AbTAMThc>; Mon, 13 Jan 2003 14:37:32 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301131946.h0DJk1w32012@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21-pre3-ac4
To: rossb@google.com (Ross Biro)
Date: Mon, 13 Jan 2003 14:46:01 -0500 (EST)
Cc: benh@kernel.crashing.org (Benjamin Herrenschmidt),
       alan@lxorguk.ukuu.org.uk (Alan Cox), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3E23114E.8070400@google.com> from "Ross Biro" at Jan 13, 2003 11:19:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> host shall wait 400 ns before reading the Status register. When entering 
> this state from the HPIOI2 state, the host shall wait one PIO transfer 
> cycle time before reading the Status register. The wait may be 
> accomplished by reading the Alternate Status register and ignoring the 
> result.

Fatal on PIIX PIO
