Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWI0RA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWI0RA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWI0Q7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:59:50 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:22007 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030244AbWI0Q7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:59:47 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 6/8] at91_serial -> atmel_serial: Internal names
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:58:03 +0200
Message-Id: <11593762851494-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11593762851544-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com> <11593762852168-git-send-email-hskinnemoen@atmel.com> <11593762851735-git-send-email-hskinnemoen@atmel.com> <11593762853931-git-send-email-hskinnemoen@atmel.com> <11593762851544-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix all internal functions and variables with atmel_ instead of
at91_.

The at91_register_uart_fns() stuff is left as is since I can't find
any actual users of it.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/atmel_serial.c |  496 +++++++++++++++++++++--------------------
 drivers/serial/atmel_serial.h |  196 ++++++++--------
 2 files changed, 346 insertions(+), 346 deletions(-)

The patch weighs in at 47K, so I put it at

http://avr32linux.org/twiki/pub/Sandbox/AtmelSerialRenamePatch/at91_serial-to-atmel_serial-internal-names.patch

instead of including it here.

Haavard
