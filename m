Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbREQAUw>; Wed, 16 May 2001 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbREQAUn>; Wed, 16 May 2001 20:20:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261350AbREQAUc>; Wed, 16 May 2001 20:20:32 -0400
Subject: Re: "clock timer configuration lost" on Serverworks chipset
To: jcastle@in-system.com (Jim Castleberry)
Date: Thu, 17 May 2001 01:17:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010516161218.A28362@osprey.in-system.com> from "Jim Castleberry" at May 16, 2001 04:12:18 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150BTS-0004iu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How well has the problem been nailed down?  Could it be that it just
> showed up first on VIA and the real cause (and fix) remains to be
> discovered?  Or does Serverworks somehow have an identical bug in
> their chipset?

There is a notional off by one in the check at least by the rules of the
original chip which do allow the overflow value to be visible momentarily.
Later -ac checks for > not >=


