Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290075AbSA3QiT>; Wed, 30 Jan 2002 11:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSA3QhL>; Wed, 30 Jan 2002 11:37:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54802 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290018AbSA3QgG>; Wed, 30 Jan 2002 11:36:06 -0500
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Wed, 30 Jan 2002 16:48:46 +0000 (GMT)
Cc: michelpereira@uol.com.br (Michel Angelo da Silva Pereira),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0201301756530.5518-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Jan 30, 2002 05:57:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vxug-0007lP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please try without the adaptec i2o driver compiled in and only 
> the generic i2o drivers. Also which kernel last worked for you?

The adaptec driver won't touch the IBM ServeRAID - that side is ok. The
generic i2o will see it as it claims to be an I2O device but the right
driver is the IBM ips driver

Alan
