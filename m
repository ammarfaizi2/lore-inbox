Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271369AbTHMEIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTHMEIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:08:15 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:33729 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271369AbTHMEIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:08:14 -0400
Date: Wed, 13 Aug 2003 00:08:10 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: sparc64: no asm/serial.h
Message-ID: <20030813040810.GA16597@zero>
Reply-To: Tom Vier <tmv@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missing a couple #defines:

drivers/serial/8250.c:106:24: asm/serial.h: No such file or directory
drivers/serial/8250.c:110: `SERIAL_PORT_DFNS' undeclared here (not in a
function)
drivers/serial/8250.c:110: initializer element is not constant
drivers/serial/8250.c:110: (near initialization for d_serial_port[0]')
drivers/serial/8250.c: In function Serial8250_request_port':
drivers/serial/8250.c:1715: warning: unused variable Size'
drivers/serial/8250.c: In function __register_serial':
drivers/serial/8250.c:2041: BASE_BAUD' undeclared (first use in this
function)
drivers/serial/8250.c:2041: (Each undeclared identifier is reported only
once
drivers/serial/8250.c:2041: for each function it appears in.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
