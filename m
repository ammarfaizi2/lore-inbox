Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318146AbSGMLLE>; Sat, 13 Jul 2002 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGMLLD>; Sat, 13 Jul 2002 07:11:03 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:53804 "EHLO
	devil.stev.org") by vger.kernel.org with ESMTP id <S318146AbSGMLLD>;
	Sat, 13 Jul 2002 07:11:03 -0400
Message-ID: <000701c22a5e$07190d90$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Anssi Saari" <as@sci.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <002d01c22882$f17436e0$0501a8c0@Stev.org> <E17ScQK-0000ih-00@the-village.bc.nu> <20020712185522.GA12751@sci.fi> <01fd01c22a4d$151c4da0$0501a8c0@Stev.org> <20020713102057.GA11996@sci.fi>
Subject: Re: ATAPI + cdwriter problem
Date: Sat, 13 Jul 2002 12:11:24 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the really bad thing is the fact that it never does reset
> > for me a reboot is required for me to use the cd drive again.
>
> Maybe you can try cdrdao unlock, I've found it seems to reset my drive
> when it hangs. I wonder why it is that cdrecord -reset doesn't do anything
> to ATAPI drives with ide-scsi.

well i think it might have todo with the function just saying success
and does nothing else

int idescsi_reset (Scsi_Cmnd *cmd, unsigned int resetflags)
{
 return SCSI_RESET_SUCCESS;
}



