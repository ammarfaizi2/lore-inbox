Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQLTS20>; Wed, 20 Dec 2000 13:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbQLTS2G>; Wed, 20 Dec 2000 13:28:06 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:7926 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129828AbQLTS1z>;
	Wed, 20 Dec 2000 13:27:55 -0500
Message-ID: <3A40F280.427D8907@ife.ee.ethz.ch>
Date: Wed, 20 Dec 2000 18:55:12 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: f5ibh <f5ibh@db0bm.ampr.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19/2.4.0-test and usbdevfs
In-Reply-To: <200012201309.OAA08128@db0bm.ampr.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> modprobe: modprobe: Can't locate module usbdevfs
> mount: fs type usbdevfs not supported by kernel

Add:

alias usbdevfs usbcore

to /etc/modules.conf

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
