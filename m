Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSEMOde>; Mon, 13 May 2002 10:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSEMOdd>; Mon, 13 May 2002 10:33:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313307AbSEMOdc>; Mon, 13 May 2002 10:33:32 -0400
Subject: Re: sg in 2.4.18
To: wt@electro-mechanical.com (William Thompson)
Date: Mon, 13 May 2002 15:53:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020513101050.A3879@coredump.electro-mechanical.com> from "William Thompson" at May 13, 2002 10:10:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177HCS-0005ZT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to open sg more than once for multiple devices?
> IE, cdrecord 2 cds at once.

Each cd writer will have its own /dev/sg* device so yes
