Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVHYKcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVHYKcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVHYKcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:32:48 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5387 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964914AbVHYKcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:32:47 -0400
Date: Thu, 25 Aug 2005 11:32:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: moreau francis <francis_moreau2000@yahoo.fr>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question on memory barrier
In-Reply-To: <20050824194836.GA26526@hexapodia.org>
Message-ID: <Pine.LNX.4.61L.0508251130590.9696@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com>
 <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
 <20050824194836.GA26526@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Andy Isaacson wrote:

> You might benefit by running your source code through gcc -E and seeing
> what the writel() expands to.  (I do something like "rm drivers/mydev.o;
> make V=1" and then copy-n-paste the gcc line, replacing the "-c -o mydev.o"
> options with -E.)

 Well, `make drivers/mydev.i' does the same and is simpler. ;-)

  Maciej
