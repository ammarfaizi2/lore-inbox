Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272256AbRIES2m>; Wed, 5 Sep 2001 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272264AbRIES2c>; Wed, 5 Sep 2001 14:28:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41223 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272256AbRIES21>; Wed, 5 Sep 2001 14:28:27 -0400
Subject: Re: Noexec flag on VFAT
To: owl@volny.cz (=?iso-8859-2?Q?Petr_Tit=ECra?=)
Date: Wed, 5 Sep 2001 19:32:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001501c13637$a5c16260$0aa76cc0@desktop> from "=?iso-8859-2?Q?Petr_Tit=ECra?=" at Sep 05, 2001 08:19:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ehTY-0006Rg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     somewhere between 2.4.9 and 2.4.9-ac5 noexec flag on VFAT filesystem
> stop to work. Is it intentional?

No it is not. Can you give me a test case and I'll check. Most probably
this is from the permission fixes to exec
