Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWG3N4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWG3N4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWG3N4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:56:46 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:23947 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932315AbWG3N4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:56:45 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 17:42:32 GMT
Message-ID: <06AU96W11@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tracked down the USB audio cards not working anymore with 2.6.17 as opposed
to 2.6.16 to the fact that opening /dev/dsp with O_RDWR works with any USB
audio card under 2.6.16 whereas starting from 2.6.17 O_WRONLY is mandatory
if the card has no mic or line in.

