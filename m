Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266725AbRGFPHE>; Fri, 6 Jul 2001 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266722AbRGFPGz>; Fri, 6 Jul 2001 11:06:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62482 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266719AbRGFPGo>; Fri, 6 Jul 2001 11:06:44 -0400
Subject: Re: reading/writing CMOS beyond 256 bytes?
To: grisha@ispol.com ("Gregory (Grisha) Trubetskoy")
Date: Fri, 6 Jul 2001 16:07:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.32.0107060829460.47924-100000@localhost> from "Gregory (Grisha) Trubetskoy" at Jul 06, 2001 08:38:12 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IXCD-0004Uu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, it seems that some settings are not in the 128 (or 256)
> bytes accessible this way, so they must be stored elsewhere.

Large numbers of BIOS settings are in the NVRAM ESCD area in modern systems
(EISA config, ISAPNP config, etc)

> Does anyone know where I should look for the remaining parts of CMOS
> (short of having to sign some NDA with Intel?)?

The PnPBIOS and ESCD specs are publically available if a little impenetrable

