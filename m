Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSDSLFU>; Fri, 19 Apr 2002 07:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSDSLFT>; Fri, 19 Apr 2002 07:05:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37645 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312119AbSDSLFT>; Fri, 19 Apr 2002 07:05:19 -0400
Subject: Re: SSE related security hole
To: nahshon@actcom.co.il
Date: Fri, 19 Apr 2002 12:22:59 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), alan@lxorguk.ukuu.org.uk (Alan Cox),
        andrea@suse.de (Andrea Arcangeli), dledford@redhat.com (Doug Ledford),
        jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <200204182320.53095.nahshon@actcom.co.il> from "Itai Nahshon" at Apr 19, 2002 01:35:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yWTj-0006vk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the FP/MMX state _are_ separate regs then they must also be
> stored/reloaded separately on a context switch.
> Is that already done? (if yes, where?)

FXSAVE/FXRSTOR
