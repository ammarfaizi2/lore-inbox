Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTJFRuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJFRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:50:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:9653 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262407AbTJFRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:50:18 -0400
Date: Mon, 6 Oct 2003 13:50:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: s390 test6 patches: descriptions.
Message-ID: <20031006135014.A16665@devserv.devel.redhat.com>
References: <mailman.1065432601.831.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <mailman.1065432601.831.linux-kernel2news@redhat.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 11:23:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

the default target seems to be broken. The old way
("make image modules") works fine. Not that I care too much,
but I got some grief in sparc about it. FYI.

itcev@niphredil linux-2.6.0-test6-s390]$ make CROSS_COMPILE=/q/cross/bin/s390-ibm-linux-gnu-  ARCH=s390
..............
  OBJCOPY arch/s390/boot/image
make[1]: *** No rule to make target `arch/s390/boot/listing'.  Stop.

-- Pete
