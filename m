Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbRE2MsK>; Tue, 29 May 2001 08:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRE2MsA>; Tue, 29 May 2001 08:48:00 -0400
Received: from [209.10.41.242] ([209.10.41.242]:49583 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261968AbRE2Mry>;
	Tue, 29 May 2001 08:47:54 -0400
Subject: Re: [patch] raid-2.4.5-A0, minor fix
To: mingo@elte.hu
Date: Tue, 29 May 2001 13:37:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105291315040.3146-200000@localhost.localdomain> from "Ingo Molnar" at May 29, 2001 01:16:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154ikm-0004Mp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the attached patch (against 2.4.5-ac3) fixes a compiler warning (triggered
> by gcc 2.96) in the RAID include files.

panic() is declared correctly as not returning. I think this is one for the
compiler team.
