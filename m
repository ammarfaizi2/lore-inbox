Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315699AbSEILSJ>; Thu, 9 May 2002 07:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315701AbSEILSJ>; Thu, 9 May 2002 07:18:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28164 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315699AbSEILSH>; Thu, 9 May 2002 07:18:07 -0400
Message-Id: <200205091114.g49BEOX25910@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
Date: Thu, 9 May 2002 13:21:19 -0200
X-Mailer: KMail [version 1.3.2]
Cc: dal_loma@yahoo.com (Amol Lad), linux-kernel@vger.kernel.org
In-Reply-To: <E175WFn-000265-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2002 16:33, Alan Cox wrote:
> > > TASK_UNINTERRUPTIBLE state ?
> >
> > No. Everytime you see hung task in this state
> > you see kernel bug.
>
> Or waiting on a resource that isnt available - that can occur for example
> with NFS for long periods, or for a few minutes when burning a CD and the
> IDE bus is locked

I really prefer interruptible NFS mode (without timeout).

If CD burner needs to completely lock IDE, well, that is less than wonderful 
piece of hardware. I won't blame kernel for this.
--
vda

