Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312769AbSCYWjC>; Mon, 25 Mar 2002 17:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312798AbSCYWiw>; Mon, 25 Mar 2002 17:38:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312797AbSCYWid>; Mon, 25 Mar 2002 17:38:33 -0500
Subject: Re: Problems with booting from SX6000
To: kjetiln@kvarteret.org (=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=)
Date: Mon, 25 Mar 2002 22:54:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020325211541.A30644@kvarteret.org> from "=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=" at Mar 25, 2002 09:15:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pdMH-0001nv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had the correct option for mounting (in grub):
> 	kernel <some kernel> ro root=/dev/i2o/hda6

That won't work. Grub/boot parser don't know /dev/i2o/hda6. Try 
root=hexvalue
