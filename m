Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267936AbTBEMUq>; Wed, 5 Feb 2003 07:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267937AbTBEMUq>; Wed, 5 Feb 2003 07:20:46 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60755 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267936AbTBEMUq>; Wed, 5 Feb 2003 07:20:46 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302051230.h15CUHd04248@devserv.devel.redhat.com>
Subject: Re: 2.4.21pre4-ac2 IDE status on PDC20268
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 5 Feb 2003 07:30:17 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030205102059.GG27959@louise.pinerecords.com> from "Tomas Szepe" at Feb 05, 2003 11:20:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The 20268 code explicitly enforces that rule. I need to talk to Andre
> > to find out exactly why. It is being done intentionally
> 
> Hmm, could you point me to the code in question?
> I can't find it.  Thanks.

Hash collision, I was remembering something else. The 20268 should be
setting up ATA66/100 unless the drive matches the blacklist

