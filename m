Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSLSPVp>; Thu, 19 Dec 2002 10:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLSPVp>; Thu, 19 Dec 2002 10:21:45 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:10904 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265736AbSLSPVo>; Thu, 19 Dec 2002 10:21:44 -0500
Date: Thu, 19 Dec 2002 16:29:42 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: module-init-tools 0.9.5
Message-ID: <20021219152942.GD26389@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ uname -r
2.4.20

[compile and install 2.5.52]

still in 2.4.20:
# depmod -V
module-init-tools 0.9.5
# depmod -ae -F /boot/System.map-2.5.52 2.5.52
#

[reboot into 2.5.52]

# modprobe pcnet32
FATAL: module pcnet32 not found.
# depmod -ae
# modprobe pcnet32
#

Hmm?

-- 
Tomas Szepe <szepe@pinerecords.com>
