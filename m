Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSIXNDL>; Tue, 24 Sep 2002 09:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSIXNDK>; Tue, 24 Sep 2002 09:03:10 -0400
Received: from 62-190-203-127.pdu.pipex.net ([62.190.203.127]:9476 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261660AbSIXNDK>; Tue, 24 Sep 2002 09:03:10 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209231615.g8NGFNu1001833@darkstar.example.net>
Subject: Re: scsi error.
To: andrew.r.cress@intel.com (Cress, Andrew R)
Date: Mon, 23 Sep 2002 17:15:23 +0100 (BST)
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D1F1@hdsmsx103.hd.intel.com> from "Cress, Andrew R" at Sep 23, 2002 07:35:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You apparently have a Data Parity Error on your SCSI bus.  Probably your
> external SCSI drive has a cable or terminator problem.  You can confirm this
> by disconnecting the external SCSI cable to see if the other drives come up
> ok.  
> You may be missing some termination, either via an external terminator or by
> turning on the drive's TERMPWR jumper on the external drive (depending on
> the type of disk cabinet you have).  Or, the external SCSI cable may be
> faulty (usually bent pins).

Also, it could be that you are using a cable designed for a Mac - those cables often don't have all of the GND lines individually connected, and can cause seemingly random problems.

John
