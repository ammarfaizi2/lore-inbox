Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbSK3NiA>; Sat, 30 Nov 2002 08:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSK3NiA>; Sat, 30 Nov 2002 08:38:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13856 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267246AbSK3NiA>; Sat, 30 Nov 2002 08:38:00 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211301345.gAUDjJO16145@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-ac1
To: lists@steffen-moser.de (Steffen Moser)
Date: Sat, 30 Nov 2002 08:45:19 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20021130114049.GA1735@steffen-moser.de> from "Steffen Moser" at Nov 30, 2002 12:40:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It reports "DMA disabled" messages on boot for all of my IDE drives:

Its a funny off the VIA driver - it turns DMA off noisily then turnd it
back on quietly for the devices it decies can do DMA/UDMA

Alan
