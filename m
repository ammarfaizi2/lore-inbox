Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269042AbRHBPkV>; Thu, 2 Aug 2001 11:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRHBPkL>; Thu, 2 Aug 2001 11:40:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48914 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269042AbRHBPkA>; Thu, 2 Aug 2001 11:40:00 -0400
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 2 Aug 2001 16:36:42 +0100 (BST)
Cc: adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 02, 2001 08:37:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SKWg-0000uC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, yes, you can already patch other subsystems to dynamically assign
> major numbers in 2.4.7. I'd like to see people do that. My patch for
> sd.c can also serve as a demonstration on how to use the new API.

Its a bit of an ugly hack but I guess its the best anyone can put together
for a 2.4 kernel tree. Going to a 32bit dev_t is going to make life so much
simpler do all of this without ugly hacks

Alan
