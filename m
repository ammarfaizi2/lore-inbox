Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbREWSe5>; Wed, 23 May 2001 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbREWSes>; Wed, 23 May 2001 14:34:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63499 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263205AbREWSeb>; Wed, 23 May 2001 14:34:31 -0400
Subject: Re: Selectively refusing TCP connections
To: linux-kernel@slimyhorror.com (Ben Mansell)
Date: Wed, 23 May 2001 19:31:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105231841230.1163-100000@baphomet.bogo.bogus> from "Ben Mansell" at May 23, 2001 06:59:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152dPw-0003va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any mechanism in Linux for refusing incoming TCP connections?

Not unless Dave added one I dont know about

> I'd like to be able to fetch the next incoming connection on a listen
> queue, and selectively accept or reject it based on the IP address of the

By the time you are notified the connection has completed. Also because we
use syn cookies you don't actually know about pending connections because the
state is all kept on the client

