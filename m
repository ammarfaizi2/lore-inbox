Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284868AbRLFAA6>; Wed, 5 Dec 2001 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284867AbRLFAAs>; Wed, 5 Dec 2001 19:00:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5896 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284856AbRLFAAk>; Wed, 5 Dec 2001 19:00:40 -0500
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
To: Martin.Bligh@us.ibm.com
Date: Thu, 6 Dec 2001 00:06:07 +0000 (GMT)
Cc: lm@bitmover.com (Larry McVoy), riel@conectiva.com.br (Rik van Riel),
        lars.spam@nocrew.org (Lars Brinkhoff),
        alan@lxorguk.ukuu.org.uk (Alan Cox), hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <2527982215.1007550329@mbligh.des.sequent.com> from "Martin J. Bligh" at Dec 05, 2001 11:05:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Bm3D-00084Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I give you 16 SMP systems, each with 4 processors and a gigabit
> ethernet card, and connect those ethers through a switch, would that
> be sufficient hardware?

Take a 16 CPU numa box thats really 4x4 + numa glue and run it as if it
was the 4 processors, 4 nodes with gige, only allowing for extra operations
"take access to remote page" "release access to remote page"

