Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTI2FuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTI2FuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:50:21 -0400
Received: from web41501.mail.yahoo.com ([66.218.93.84]:39825 "HELO
	web41501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262848AbTI2FuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:50:18 -0400
Message-ID: <20030929055017.83669.qmail@web41501.mail.yahoo.com>
Date: Sun, 28 Sep 2003 22:50:17 -0700 (PDT)
From: Panos Christeas <p_christeas@yahoo.com>
Subject: Re: Linux-2.6.0-test6: synaptics upside down?
To: peter@chubb.wattle.id.au
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi folks,
>   On the latest 2.6.0-test6 kernel, the synaptics
>touchpad on my
>Clevo is upside down -- moving my finger up moves the
>pointer down, et vice versa.

>This patch fixed the problem for me, but is probably
not >the right fix.

Have a a look at the 'configuration bits' that the
touchpad reports to the driver. These indicate the
type and *position* of the touchpad. You can safely
deduct from those if the transformation applies or
not.

btw. Has anybody come accross a 90deg mounted pad?


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
