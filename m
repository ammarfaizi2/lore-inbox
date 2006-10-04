Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWJDGOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWJDGOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWJDGOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:14:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7571 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030396AbWJDGOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:14:18 -0400
Message-ID: <45235137.4040604@garzik.org>
Date: Wed, 04 Oct 2006 02:14:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org
Subject: DVB Kconfig warning in latest kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing 'make allyesconfig && make -sj4' on x86_64:

drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config 
symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'

