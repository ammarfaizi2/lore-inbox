Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRHFEsD>; Mon, 6 Aug 2001 00:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbRHFErx>; Mon, 6 Aug 2001 00:47:53 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:15879 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266706AbRHFErq>;
	Mon, 6 Aug 2001 00:47:46 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: middelin@polyware.nl, Alan Cox <alan@redhat.com>
Subject: drivers/media/video/videodev.c uses init_zoran_cards.  2.4.8-pre4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 14:47:52 +1000
Message-ID: <386.997073272@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/video/videodev.c calls init_zoran_cards but that symbol
does not exist in 2.4.8-pre4.  It looks like a hangover from the rework
of the zoran drivers.

