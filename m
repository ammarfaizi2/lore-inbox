Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279257AbRJWFmk>; Tue, 23 Oct 2001 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279254AbRJWFmU>; Tue, 23 Oct 2001 01:42:20 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:50693
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S279253AbRJWFmI>; Tue, 23 Oct 2001 01:42:08 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110230522.f9N5M2g03266@www.hockin.org>
Subject: Re: PCI PIRQ routing questions..
To: john@deater.net (John Clemens)
Date: Mon, 22 Oct 2001 22:22:02 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0110230052560.3178-100000@pianoman.cluster.toy> from "John Clemens" at Oct 23, 2001 01:06:11 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> everything else on the laptop is set to IRQ11. (well, enet, cardbus,
> video).  I tried using setpci to change the USB irq to something unused

On many systems USB is an internal IRQ route, not configurable through PIRQ
at all, despite what the PIRQ table tells you.

Just a possibility.
