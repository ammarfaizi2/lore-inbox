Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBNMXF>; Wed, 14 Feb 2001 07:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBNMWz>; Wed, 14 Feb 2001 07:22:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60686 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130152AbRBNMWm>; Wed, 14 Feb 2001 07:22:42 -0500
Subject: Re: 2.4.1-ac12 compile failure on sparc64
To: Alastair.Stevens@bristol.ac.uk (ASN Stevens, Computing Service)
Date: Wed, 14 Feb 2001 12:23:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <EXECMAIL.1010214113238.Y@velifer.bris.ac.uk> from "ASN Stevens, Computing Service" at Feb 14, 2001 11:32:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T0xy-0004ly-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have tried upgrading to -ac10 and now -ac12, but both fail during 
> compilation (using gcc-2.91.66-sparc) at the same point, in what appears to 
> be the sparc32 syscall conversion code:

The -ac tree doesnt currently support sparc because nobody has written the
32/64bit converts for the new quota structs.
