Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291050AbSBGBbF>; Wed, 6 Feb 2002 20:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291051AbSBGBax>; Wed, 6 Feb 2002 20:30:53 -0500
Received: from sushi.toad.net ([162.33.130.105]:31433 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S291050AbSBGBag>;
	Wed, 6 Feb 2002 20:30:36 -0500
Subject: Re: modular floppy broken in 2.5.3
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Gunther Mayer <gunther.mayer@gmx.net>,
        Alessandro Suardi <alessandro.suardi@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 20:30:50 -0500
Message-Id: <1013045453.2789.511.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the PnP BIOS driver, available at:
   http://panopticon.csustan.edu/thood/pnpbios.html
refrains from reserving ioports 0x3f0 and 0x3f1.  This
is a temporary fix for the floppy problem.  I hope
someone will fix the floppy driver soon so that this
change can be reverted.

Note that at earlier version of the driver was included
in 2.4.18-pre7-ac2 and an even earlier version was
included in 2.5.3.  If you are using either of these
kernels and you don't want to update the pnpbios driver
then boot with "pnpbios=no-res".

--
Thomas

