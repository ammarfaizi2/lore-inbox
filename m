Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSCYM14>; Mon, 25 Mar 2002 07:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSCYM1r>; Mon, 25 Mar 2002 07:27:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312413AbSCYM1h>; Mon, 25 Mar 2002 07:27:37 -0500
Subject: Re: Problems with booting from SX6000
To: kjetiln@kvarteret.org (=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=)
Date: Mon, 25 Mar 2002 12:43:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020325024022.A6502@kvarteret.org> from "=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=" at Mar 25, 2002 02:40:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pTp5-0000RP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Partition Check: 
> i2o/hda: i2o/hda1 i2o/hda2 i2o/hda3 i2o/hda4 < i2o/hda5 i2o/hd6 >
> Loading jbd module

It found your SX6000

> Creating root device
> Mounting root filesystem
> Mounting: error 19 ext3

And mount failed (No such device).

That sounds like your root= line is wrong in the lilo setup. I'd assumed it
was getting further then hanging
