Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTJKP5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJKP5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:57:51 -0400
Received: from bgp01014595bgs.rosvle01.mi.comcast.net ([68.41.212.184]:19245
	"EHLO bgp01015244bgs.rosvle01.mi.comcast.net") by vger.kernel.org
	with ESMTP id S263051AbTJKP5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:57:50 -0400
From: Chris Smith <chris@realcomputerguy.com>
To: linux-kernel@vger.kernel.org
Subject: make modules_install error 2.4.23-pre7
Date: Sat, 11 Oct 2003 11:57:48 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310111157.49598.chris@realcomputerguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't get past this error when doing a make_modules with 2.4.23-pre7:

cd /lib/modules/2.4.23-pre7; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.23-pre7; fi
depmod: *** Unresolved symbols in       											
/lib/modules/2.4.23-pre7/kernel/drivers/usb/usbnet.o
depmod:         generic_mii_ioctl_Rc7a0a077

Chris
