Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTCTQKS>; Thu, 20 Mar 2003 11:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTCTQKS>; Thu, 20 Mar 2003 11:10:18 -0500
Received: from avscan1.sentex.ca ([199.212.134.11]:60166 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S261525AbTCTQKR>; Thu, 20 Mar 2003 11:10:17 -0500
Message-ID: <02e201c2eefd$1abe2240$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Andrzej Krzysztofowicz" <ankry@green.mif.pg.gda.pl>,
       "kernel list" <linux-kernel@vger.kernel.org>
References: <200303201615.h2KGF3r2002546@green.mif.pg.gda.pl>
Subject: Re: Non-__init functions calling __init functions
Date: Thu, 20 Mar 2003 11:23:55 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrzej Krzysztofowicz" <ankry@green.mif.pg.gda.pl>
> From: "Stuart MacDonald" <stuartm@connecttech.com>
> > This is always a bug isn't it?
>
> ... unless they are guaranteed to be called in the init context only.

In which case those functions should also be marked __init so they can
be reclaimed, correct? So it's the reciprocal bug.

..Stu


