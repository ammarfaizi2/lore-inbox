Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269976AbRHWTBp>; Thu, 23 Aug 2001 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270017AbRHWTBg>; Thu, 23 Aug 2001 15:01:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269976AbRHWTBV>; Thu, 23 Aug 2001 15:01:21 -0400
Subject: Re: releasing driver to kernel in source+binary format
To: hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)")
Date: Thu, 23 Aug 2001 20:04:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3F@xsj02.sjs.agilent.com> from "MEHTA,HIREN (A-SanJose,ex1)" at Aug 23, 2001 12:43:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZzmR-0004O1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, Qlogic also has their firmware released in binary format.

Firmware that runs on the processor in the card is somewhat of a different
item. If its just a binary firmware image to load into the card and that
is run by the card I dont think its an issue.

If its code run on the host processor then there is an issue.

A good rule of thumb test for that is "could you write a seperate program
that loaded the firmware and wasnt part of the kernel". 


Alan
