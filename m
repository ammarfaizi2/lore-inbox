Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTJHOpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJHOpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:45:46 -0400
Received: from linux-bt.org ([217.160.111.169]:25997 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261598AbTJHOpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:45:46 -0400
Subject: Re: [PATCH 2/14] firmware update for av7110 dvb driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <10656197272107@convergence.de>
References: <10656197272107@convergence.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Oct 2003 16:45:01 +0200
Message-Id: <1065624307.5470.242.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> ... send to Linus only. (You don't want a 150kB bzip2 compressed firmware blob, don't you? In case you do, drop me a line.)

the request_firmware() framework is part of Linux 2.4 and 2.6 and so for
most drivers the firmware file can be loaded from userspace through proc
or sysfs. Please take a look at it.

Regards

Marcel


