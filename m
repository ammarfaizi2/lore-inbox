Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281019AbRKKJA3>; Sun, 11 Nov 2001 04:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281044AbRKKJAU>; Sun, 11 Nov 2001 04:00:20 -0500
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:51269 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S281019AbRKKJAE>;
	Sun, 11 Nov 2001 04:00:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Error message during modules_install of 2.4.14
Date: Sun, 11 Nov 2001 10:01:03 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111110010300.23755@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi developers

During "make modules_install" I got the following error message:

mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.14; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.14/kernel/drivers/block/loop.o
depmod:         deactivate_page

Is this something to worry about?

Bye, Peter.

