Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbSJSBH1>; Fri, 18 Oct 2002 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbSJSBH1>; Fri, 18 Oct 2002 21:07:27 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:11430 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265439AbSJSBHI>; Fri, 18 Oct 2002 21:07:08 -0400
Date: Fri, 18 Oct 2002 21:05:36 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.43 : drivers/ieee1394/sbp2.c compile error 
Message-ID: <Pine.LNX.4.44.0210182101530.16040-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make modules', I received the following error.
Regards,
Frank

drivers/ieee1394/sbp2.c:1516: conflicting types for `sbp2_handle_physdma_write'
drivers/ieee1394/sbp2.h:513: previous declaration of `sbp2_handle_physdma_write'
drivers/ieee1394/sbp2.c:1532: conflicting types for `sbp2_handle_physdma_read'
drivers/ieee1394/sbp2.h:515: previous declaration of `sbp2_handle_physdma_read'
make[2]: *** [drivers/ieee1394/sbp2.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2

