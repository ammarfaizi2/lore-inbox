Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311698AbSCNRyn>; Thu, 14 Mar 2002 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311705AbSCNRyd>; Thu, 14 Mar 2002 12:54:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311698AbSCNRyZ>; Thu, 14 Mar 2002 12:54:25 -0500
Subject: Re: IO delay, port 0x80, and BIOS POST codes
To: Martin.Wilck@fujitsu-siemens.com (Martin Wilck)
Date: Thu, 14 Mar 2002 18:10:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.33.0203141802330.1477-100000@biker.pdb.fsc.net> from "Martin Wilck" at Mar 14, 2002 06:11:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lZg3-0001Ug-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately we can't read this information because Linux uses
> port 80 as "dummy" port for delay operations. (outb_p and friends,
> actually there seem to be a more hard-coded references to port
> 0x80 in the code).

The dummy port needs to exist. By using 0x80 we have probably the only
port we can safely use in this way. We know it fouls old style POST 
boards on odd occasions.

Alan

