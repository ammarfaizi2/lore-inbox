Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290768AbSAaAVP>; Wed, 30 Jan 2002 19:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSAaAVF>; Wed, 30 Jan 2002 19:21:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290768AbSAaAUx>; Wed, 30 Jan 2002 19:20:53 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: andersen@codepoet.org
Date: Thu, 31 Jan 2002 00:33:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), greg@kroah.com (Greg KH),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020130234847.GA25577@codepoet.org> from "Erik Andersen" at Jan 30, 2002 04:48:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16W5AC-0000a5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is in the latest -ac kernels?  Cool, I'll go take a close
> look.  I'm very anxious to see a SCSI layer that doesn't suck
> get put in place,

The scsi mid layer is a seperate problem, and its getting there already in
2.5. Chunks of nasty scsi special cases keep dissappearing with the bio stuff

The NCR5380 stuff fixes what was an amazingly crufty unmaintained driver

