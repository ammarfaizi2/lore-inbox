Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSFRQyQ>; Tue, 18 Jun 2002 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSFRQyP>; Tue, 18 Jun 2002 12:54:15 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:61141 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317488AbSFRQyP>; Tue, 18 Jun 2002 12:54:15 -0400
Date: Tue, 18 Jun 2002 11:54:12 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make dep fails on 2.5.22 
In-Reply-To: <200206181628.g5IGSP805899@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206181153000.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, James Bottomley wrote:

> kai@tp1.ruhr-uni-bochum.de said:
> > Well, actually, it looks right to me: It says to build the .ver file,
> > we need the header (since it'll be included during the process). 
> 
> OK, I can fix all the SCSI auto generated headers this way and submit the 
> patch.  By "wrong" I meant it doesn't appeal to my programmer's sense of 
> laziness to have two separate rules for the same thing, but I can live with it.

I think this one is the only one (at least in drivers/scsi), since it's 
only needed for objects which export symbols, i.e are listed in 
$(export-objs).

--Kai


