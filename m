Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBBVwb>; Fri, 2 Feb 2001 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRBBVwL>; Fri, 2 Feb 2001 16:52:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47624 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129057AbRBBVwD>; Fri, 2 Feb 2001 16:52:03 -0500
Subject: Re: Every Make option ends in error.
To: ken@kenmoffat.uklinux.net (Ken Moffat)
Date: Fri, 2 Feb 2001 21:53:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102022052090.31663-100000@localhost.localdomain> from "Ken Moffat" at Feb 02, 2001 08:59:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Oo8f-0007FD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Copied a plain 2.4.0 tree to a new directory, patched it to 2.4.1 without
> any errors. Then I realised it had all the object files from my last
> compile, so I thought "make mrproper" was called for. It did a little,
> then

You copied the link and turned it into its contents

> rm: include/asm: is a directory
> make: *** [mrproper] Error 1

do rm -rf include/asm and then rerun the makes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
