Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313707AbSDPRNM>; Tue, 16 Apr 2002 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313770AbSDPRNL>; Tue, 16 Apr 2002 13:13:11 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28290 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313707AbSDPRNJ>; Tue, 16 Apr 2002 13:13:09 -0400
Date: Tue, 16 Apr 2002 11:12:58 -0600
Message-Id: <200204161712.g3GHCw513349@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, khalid_aziz@hp.com
Subject: OK, who broke the serial driver in 2.4.19-pre7?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. 2.4.19-pre7 has broken the serial driver. With 2.4.19-pre6
and before, my first serial port was ttyS0 (4, 64), and I got these
kernel messages:
ttyS00 at 0x03f8 (irq = 4) is a 16550A 
ttyS01 at 0x02f8 (irq = 3) is a 16550A 

With 2.4.19-pre7, my first serial port is ttyS1 (4, 65), and I get:
ttyS01 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x02f8 (irq = 3) is a 16550A

Was this broken by the HCDP serial ports changes?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
