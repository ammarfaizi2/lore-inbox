Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVE1UxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVE1UxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 16:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVE1UxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 16:53:09 -0400
Received: from [62.203.50.252] ([62.203.50.252]:35129 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261182AbVE1UxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 16:53:06 -0400
Date: Sat, 28 May 2005 22:48:36 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>
Subject: i2c-parport disappeared from 2.6.11.9
Message-ID: <20050528204836.GA20763@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Drivers -> I2C -> Busses -> Parallel port adapter disappeared in
2.6.11.9. However the source drivers/i2c/busses/i2c-parport.c
and i2c-parport.h are still there.

There is only parallel port light (i2c-parport-light.c) in the make
menuconfig menu.

I am working on a driver in i2c-parport.c. What should I do? Stop the
work and forget it? Or continue?

I took care to turn on "Prompt for development and/or incomplete
code/drivers" and turn off "Select only drivers expected to compile
cleanly".

CL<
