Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUFKGPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUFKGPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFKGPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:15:38 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:2317 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S261907AbUFKGPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:15:36 -0400
Date: Fri, 11 Jun 2004 08:15:33 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc3 can't mount my USB memory Stick any more
Message-ID: <20040611061533.GA2920@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

till 2.6.7-rc2 I can access my USB memory Stick without problem, but not
with 2.6.7-rc3... which gave strange partition on it :

sk /dev/sdg: 520 MB, 520092160 bytes
16 heads, 62 sectors/track, 1023 cylinders
Units = cylinders of 992 * 512 = 507904 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdg1   ?      784412     1935127   570754815+  72  Unknown
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(357, 116, 40) logical=(784411, 3, 11)
Partition 1 has different physical/logical endings:
     phys=(357, 32, 45) logical=(1935126, 8, 51)
Partition 1 does not end on cylinder boundary.
/dev/sdg2   ?      170050     2121692   968014120   65  Novell Netware 386
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(288, 115, 43) logical=(170049, 14, 47)
Partition 2 has different physical/logical endings:
     phys=(367, 114, 50) logical=(2121691, 4, 42)
Partition 2 does not end on cylinder boundary.
/dev/sdg3   ?     1884962     3836603   968014096   79  Unknown
Partition 3 has different physical/logical beginnings (non-Linux?):
     phys=(366, 32, 33) logical=(1884961, 2, 30)
Partition 3 has different physical/logical endings:
     phys=(357, 32, 43) logical=(3836602, 7, 39)
Partition 3 does not end on cylinder boundary.
/dev/sdg4   ?           1     3666559  1818613248    d  Unknown
Partition 4 has different physical/logical beginnings (non-Linux?):
     phys=(372, 97, 50) logical=(0, 0, 1)
Partition 4 has different physical/logical endings:
     phys=(0, 10, 0) logical=(3666558, 15, 30)
Partition 4 does not end on cylinder boundary.

Partition table entries are not in disk order

Any reason for that?

Please CC to me as I only read the list through nntp ;-)

	Grégoire
__________________________________________________________________________
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
