Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315332AbSEHVyt>; Wed, 8 May 2002 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315357AbSEHVys>; Wed, 8 May 2002 17:54:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315332AbSEHVyr>; Wed, 8 May 2002 17:54:47 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: andersen@codepoet.org
Date: Wed, 8 May 2002 23:14:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020508211633.GA24938@codepoet.org> from "Erik Andersen" at May 08, 2002 03:16:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175ZhR-0002Uu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That suggests to me that IDE floppy needs to be fixed to open
> even when no media is present when provided with the  O_NONBLOCK
> flag, which would be consistant with how CDROMs, and everything
> SCSI works.
> 
> As for ide-scsi, I thought that was going to go away?  

If we move to a more general device tree and you can set the mode you wish
to use when accessing the device it can do. Right now the "mode" so to
speak is implied by the file you open rather than by how you send it
commands and what you ask it to do
