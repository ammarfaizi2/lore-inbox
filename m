Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSAFLQr>; Sun, 6 Jan 2002 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287828AbSAFLQh>; Sun, 6 Jan 2002 06:16:37 -0500
Received: from [129.27.43.9] ([129.27.43.9]:13834 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S287817AbSAFLQ0>;
	Sun, 6 Jan 2002 06:16:26 -0500
Date: Sun, 6 Jan 2002 12:16:17 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems? -> new idea...
Message-ID: <Pine.LNX.4.10.10201061214220.17760-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Lionel Bouton wrote:

> MAC configuration is a dream we can't touch.


I just had an idea in case what we might do in case of complex
hardware....

We already have the "command line parameter" that we can provide to the
kernel.

Maybe the best thing would be to supply the kernel a "large" _textfile_
with all the hardware the user definitely has (at such-and such
irq/dma/io); the textfile could be the output resilt from a
"userfriendly" hardware-detection tool that lists all categories of
hardwares etc. and has - generally - a large hardware database. 

And no, I don't mean "etc/modules.conf", since it probably resides on an
SCSI harddisk that can't be accessed due to SCSI hardware problems
(instead of SCSI, insert other problematic devices here, USB harddisks
etc)

What do you think?

Yours, Alex



