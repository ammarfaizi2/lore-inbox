Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbREXWVf>; Thu, 24 May 2001 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262413AbREXWVZ>; Thu, 24 May 2001 18:21:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13832 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262424AbREXWVM>; Thu, 24 May 2001 18:21:12 -0400
Subject: Re: Dying disk and filesystem choice.
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Thu, 24 May 2001 23:16:58 +0100 (BST)
Cc: reiser@namesys.com (Hans Reiser), ak@suse.de (Andi Kleen),
        adilger@turbolinux.com (Andreas Dilger),
        monkeyiq@users.sourceforge.net (monkeyiq),
        linux-kernel@vger.kernel.org, god@namesys.com (Nikita Danilov)
In-Reply-To: <20010524214641.E10968@arthur.ubicom.tudelft.nl> from "Erik Mouw" at May 24, 2001 09:46:41 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1533Pf-0005gt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO we are not that deep into code freeze anymore. Freevxfs got added
> in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
> like badblock support would be OK.

FreeVxFS changes precisely nothing in the behaviour of any other fs - its like
adding a new driver.

Updating Reiserfs requires a lot more care because it has the potential to
harm existing stable setups

