Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSKHONG>; Fri, 8 Nov 2002 09:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbSKHONG>; Fri, 8 Nov 2002 09:13:06 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:34178 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S262040AbSKHONF>;
	Fri, 8 Nov 2002 09:13:05 -0500
Date: Fri, 8 Nov 2002 09:19:31 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19 + patch-20-pre11 Broken NVidia FB
Message-ID: <20021108141931.GA1319@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Rebuilt my home machine last night.  Used my 2.4.18 .config file as
passing it down the chain as always.  Made the kernel with the standard
alias and rebooted.  BRIGHT GREEN screen.  Rebooted to an older 2.4.18
kernel, changed a few options, no go.  On a guess I removed the
FrameBuffer option from the console menu and tried again.  Box is up and
working great.  In addition, when the FB was compiled into the kernel or
as a module X wouldn't work, said it couldn't find the NVidia kernel
module.  Excluding the kernel frame buffer worked great.

P4-2Ghz, 1Gig of ram, GForce3-64Meg.

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

