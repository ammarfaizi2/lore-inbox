Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTBEIIM>; Wed, 5 Feb 2003 03:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTBEIIL>; Wed, 5 Feb 2003 03:08:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34262 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267852AbTBEIIL>; Wed, 5 Feb 2003 03:08:11 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302050817.h158Hic14888@devserv.devel.redhat.com>
Subject: Re: 2.4.21pre4-ac2 IDE status on PDC20268
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 5 Feb 2003 03:17:44 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030205063058.GA27959@louise.pinerecords.com> from "Tomas Szepe" at Feb 05, 2003 07:30:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but misdetects the max transfer rate of the only drive on the
> secondary channel and then won't allow me to set UDMA > 2 on it
> (I get no error msg but there's no change).

The 20268 code explicitly enforces that rule. I need to talk to Andre
to find out exactly why. It is being done intentionally

