Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRDQLbX>; Tue, 17 Apr 2001 07:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDQLbM>; Tue, 17 Apr 2001 07:31:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11790 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132118AbRDQLbL>; Tue, 17 Apr 2001 07:31:11 -0400
Subject: Re: PROBLEM: Slowdown for ATA/100 drive on PCI card, after 2.4.3 upgrade.
To: bdbryant@mail.utexas.edu (Bobby D. Bryant)
Date: Tue, 17 Apr 2001 12:33:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <3ADAF034.C4146DB5@mail.utexas.edu> from "Bobby D. Bryant" at Apr 16, 2001 07:14:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pTjP-0002AT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
> 
> ATA/100 drive on PCI ATA/100 controller was very fast under 2.4.0 and
> 2.4.2, but becomes *very* slow under 2.4.3

Known problem with the VIA cipset setups. We turn a lot of features off to
try and avoid a hardware problem. VIA have finally released an 'official'
fix which seems to be a lot less damaging to performance on the whole. That
I hope will be in 2.4.4

