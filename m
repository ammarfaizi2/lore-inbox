Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317481AbSFRQ2a>; Tue, 18 Jun 2002 12:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSFRQ23>; Tue, 18 Jun 2002 12:28:29 -0400
Received: from host194.steeleye.com ([216.33.1.194]:32273 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317481AbSFRQ22>; Tue, 18 Jun 2002 12:28:28 -0400
Message-Id: <200206181628.g5IGSP805899@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: make dep fails on 2.5.22 
In-Reply-To: Message from Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> 
   of "Tue, 18 Jun 2002 11:22:21 CDT." <Pine.LNX.4.44.0206181115180.5695-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Jun 2002 11:28:25 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kai@tp1.ruhr-uni-bochum.de said:
> Well, actually, it looks right to me: It says to build the .ver file,
> we need the header (since it'll be included during the process). 

OK, I can fix all the SCSI auto generated headers this way and submit the 
patch.  By "wrong" I meant it doesn't appeal to my programmer's sense of 
laziness to have two separate rules for the same thing, but I can live with it.

James


