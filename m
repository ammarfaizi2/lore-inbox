Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbRFKODq>; Mon, 11 Jun 2001 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264547AbRFKODf>; Mon, 11 Jun 2001 10:03:35 -0400
Received: from [195.6.125.97] ([195.6.125.97]:50194 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S263078AbRFKOD2>;
	Mon, 11 Jun 2001 10:03:28 -0400
Date: Mon, 11 Jun 2001 16:03:30 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: netif_start_queue
Message-Id: <20010611160330.42083f1e.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm trying to port a ethernet device from 2.2 to 2.4. whith the new way of
dealing with dev->tbusy and dev->start (e.g. by using netif_startqueue for
example) I've understand that the netif_start_queue call put a flag that
telling
the device isn't busy but I can't found when does the start flag is set .

I've read somewhere that it is set when the open function return, but I
haven't
found where is the matching code.

In 2.4, must we always check if the device is busy or started, or it is
upper
layer work ?

Thanks

nb : Is somebody have buy the Linux Device driver book 2nd edition ? and
does it
deal about porting 2.2 to 2.4 driver ?

sebastien person
