Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314625AbSEHSOW>; Wed, 8 May 2002 14:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314740AbSEHSOW>; Wed, 8 May 2002 14:14:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18961 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314625AbSEHSOV>; Wed, 8 May 2002 14:14:21 -0400
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 8 May 2002 19:33:31 +0100 (BST)
Cc: dal_loma@yahoo.com (Amol Lad), linux-kernel@vger.kernel.org
In-Reply-To: <200205081519.g48FJEX24062@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at May 08, 2002 06:23:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175WFn-000265-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TASK_UNINTERRUPTIBLE state ?
> 
> No. Everytime you see hung task in this state
> you see kernel bug.

Or waiting on a resource that isnt available - that can occur for example
with NFS for long periods, or for a few minutes when burning a CD and the
IDE bus is locked
