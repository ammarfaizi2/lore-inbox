Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313236AbSDOXKZ>; Mon, 15 Apr 2002 19:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDOXKY>; Mon, 15 Apr 2002 19:10:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313236AbSDOXKX>; Mon, 15 Apr 2002 19:10:23 -0400
Subject: Re: link() security
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 16 Apr 2002 00:28:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3CBB5C9F.6020001@zytor.com> from "H. Peter Anvin" at Apr 15, 2002 04:05:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xFtQ-0007Gp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And then unrealized when they hit performance limitations. Its a trade off
> > and one that most news systems seem to prefer to use a custom database
> > for
> 
> Well, a database is basically a custom filesystem.

I would have to disagree. There are fundamentally different transaction
semantics between the two as well as indexing constraints. I can't for
example find commit() and rollback() in posix.1 8)


