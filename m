Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312831AbSCZCMD>; Mon, 25 Mar 2002 21:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312917AbSCZCLx>; Mon, 25 Mar 2002 21:11:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29711 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312831AbSCZCLp>; Mon, 25 Mar 2002 21:11:45 -0500
Subject: Re: Problems with booting from SX6000
To: kjetiln@kvarteret.org (=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=)
Date: Tue, 26 Mar 2002 02:27:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020326023338.A6882@kvarteret.org> from "=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=" at Mar 26, 2002 02:33:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pggf-0002GJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where does I find the hexvalues for /dev/i2o/hda?
> 
> Are the hexvalues static if I insert a new ide harddisk or a scsi harddisk?

The values are always static - Its 256*major+minor number. Its the one thing
that always works. Not knowing i2o/hd* is a PITA.

You want 0x5000 for i2o/hda  0x5006 for i2o/hda6   

(See Documentation/devices.txt for the values)
