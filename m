Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277232AbRJDVTo>; Thu, 4 Oct 2001 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277234AbRJDVTe>; Thu, 4 Oct 2001 17:19:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277232AbRJDVT1>; Thu, 4 Oct 2001 17:19:27 -0400
Subject: Re: [POT] Which journalised filesystem ?
To: andre.dahlqvist@telia.com (=?iso-8859-1?Q?Andr=E9?= Dahlqvist)
Date: Thu, 4 Oct 2001 22:25:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011003173448.C2337@telia.com> from "=?iso-8859-1?Q?Andr=E9?= Dahlqvist" at Oct 03, 2001 05:34:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFzU-0004H7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Alan mentioned this was something to do with the IBM hard disk
> > having strange write-cache properties that confuse ext3.
> 
> Which IBM harddrive(s) does this? How can one check if it does?

Its not specifically IBM, there are two sets of things to watch out for

-	Cache flush as a nop/unimplemented. This is legal in all but the
	most recent ATA specification. The spec has been tightened so that
	problem will go in time

-	Some IBM laptop drives appeared to fail to write back the cache on
	machine shutdown/suspend etc. The exact rights/wrongs/details on
	that one haven't been pinned down because the folks concerned
	swapped a couple of drives for different ones, saw the problem
	vanish and being a large organisation had the supplier replace the
	other fifty odd. 

Alan
