Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUH3IHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUH3IHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUH3IHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:07:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:39050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267285AbUH3IHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:07:37 -0400
Date: Mon, 30 Aug 2004 01:05:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] Add support for Possio GCC AKA PCMCIA Siemens MC45
Message-Id: <20040830010546.5c7fa532.akpm@osdl.org>
In-Reply-To: <20040830015018.GB5298@vana.vc.cvut.cz>
References: <20040830015018.GB5298@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
>    This ugly hack add support for Siemens MC45 PCMCIA GPRS card (which is
>  identical to Possio GCC, and which is offered by one of our local GPRS
>  providers).

drivers/serial/serial_cs.c: In function `wakeup_card':
drivers/serial/serial_cs.c:139: `MANFID_SIEMENS' undeclared (first use in this function)
drivers/serial/serial_cs.c:139: (Each undeclared identifier is reported only once
drivers/serial/serial_cs.c:139: for each function it appears in.)
drivers/serial/serial_cs.c:139: `PRODID_SIEMENS_MC45' undeclared (first use in this function)
drivers/serial/serial_cs.c: In function `multi_config':
drivers/serial/serial_cs.c:594: `MANFID_SIEMENS' undeclared (first use in this function)
drivers/serial/serial_cs.c:594: `PRODID_SIEMENS_MC45' undeclared (first use in this function)

