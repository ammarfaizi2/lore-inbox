Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288802AbSAQOVx>; Thu, 17 Jan 2002 09:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSAQOVl>; Thu, 17 Jan 2002 09:21:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55561 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288802AbSAQOVf>; Thu, 17 Jan 2002 09:21:35 -0500
Subject: Re: "SCSI storage controller: Adaptec 7896"
To: andy@spylog.ru (Andrey Nekrasov)
Date: Thu, 17 Jan 2002 13:55:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020117075800.GB3774@spylog.ru> from "Andrey Nekrasov" at Jan 17, 2002 10:58:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RD0l-0003P6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Type:   Direct-Access                    ANSI SCSI revision: 03
> @samson:/proc/scsi$ 
> 
> 4.
> 
> This is error disk or scsi cable?
> Way not repeat try I/O ?

SCSI parity is not robust error checking. If you get a scsi parity error it
means somthing bad is going on and it needs attention.

Alan

