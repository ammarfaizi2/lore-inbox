Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311288AbSCQERY>; Sat, 16 Mar 2002 23:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311287AbSCQERO>; Sat, 16 Mar 2002 23:17:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311290AbSCQERC>; Sat, 16 Mar 2002 23:17:02 -0500
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 17 Mar 2002 04:31:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        yodaiken@fsmlabs.com, paulus@samba.org (Paul Mackerras),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020317041219.GB14116@tapu.f00f.org> from "Chris Wedgwood" at Mar 16, 2002 08:12:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mSKM-0001oa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Either way, we have tens of MB of ram where we either put textures,
> options or whatever --- the CPU has to meddle with it one way or
> another.

The disk DMA's it to RAM, the graphics card fetches it via the GART
mappings. We shouldn't be touching a lot of it. 

