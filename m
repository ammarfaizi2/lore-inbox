Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbREMQsy>; Sun, 13 May 2001 12:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbREMQso>; Sun, 13 May 2001 12:48:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60678 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261419AbREMQse>; Sun, 13 May 2001 12:48:34 -0400
Subject: Re: ENOIOCTLCMD?
To: jlundell@pobox.com (Jonathan Lundell)
Date: Sun, 13 May 2001 17:45:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <p05100311b72454f710ce@[207.213.214.37]> from "Jonathan Lundell" at May 13, 2001 08:15:08 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yyzd-0006iH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I was arguing (conceptually) is that something like
> #define ENOIOCTLCMD ENOTTY
> or preferably but more invasively s/ENOIOCTLCMD/ENOTTY/ (mutatis mutandis)
> 
> would result in no loss of function. I assert that ENOIOCTLCMD is 
> redundant, pending a specific counterexample.

On the contrary. I can now no longer force an unsupported response when there
is a generic routine I dont wish to use

