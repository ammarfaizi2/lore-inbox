Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVCMQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVCMQyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVCMQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:54:38 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:20755 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261370AbVCMQyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:54:36 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [2.6.11.3] gcc4 / psmouse.h - compilation fix.
Date: Sun, 13 Mar 2005 17:54:30 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200503131420.12554.pluto@pld-linux.org> <200503131148.46417.dtor_core@ameritech.net>
In-Reply-To: <200503131148.46417.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503131754.31244.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 of March 2005 17:48, Dmitry Torokhov wrote:
> On Sunday 13 March 2005 08:20, Paweł Sikora wrote:
> > Hi,
> >
> > Attched patch fixes gcc error:
> > `drivers/input/mouse/psmouse.h:40: error: field `ps2dev' has incomplete
> > type`
>
> What file fails compilation?

custom patch for trackpoint device.

> As far as I can see all users of psmouse.h do 
> #include <linux/libps2.h> first.

IMHO each header (e.g. psmouse.h) should include headers for types it uses.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
