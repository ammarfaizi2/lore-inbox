Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRL2OpF>; Sat, 29 Dec 2001 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRL2Ooz>; Sat, 29 Dec 2001 09:44:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283244AbRL2Oou>; Sat, 29 Dec 2001 09:44:50 -0500
Subject: Re: Sound stops while playing DVD with via82cxxx_audio driver
To: andre.dahlqvist@telia.com (=?iso-8859-1?Q?Andr=E9?= Dahlqvist)
Date: Sat, 29 Dec 2001 14:55:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011229133642.GA679@telia.com> from "=?iso-8859-1?Q?Andr=E9?= Dahlqvist" at Dec 29, 2001 02:36:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KKtS-0004ZW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> features in the bios to disabled, but still the same thing happens. I'm
> starting to think that someting has gone wrong with the DVD-drive,
> especially since the same thing happens in that other OS.

It doesn't sound like the DVD drive. The fact that poking the ac97 side of
things wakes it up is strange. When you are playing DVD movies the actual
audio decode is coming off the processor.

Alan
