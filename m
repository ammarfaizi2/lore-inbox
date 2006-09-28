Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWI1JB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWI1JB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWI1JB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:01:56 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:43269 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751702AbWI1JB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:01:56 -0400
Subject: Re: [PATCH 5/8] at91_serial -> atmel_serial: Public definitions
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <11593762851544-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159433643.23154.47.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 10:54:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> Rename the following public definitions:
>   * AT91_NR_UART -> ATMEL_NR_UART

Can you possible rather rename it to ATMEL_MAX_UART ?

Since most AT91 board don't use all the UART's I've had a few reports of
people trying to limit the number of UART's "detected" by changing this
value - which of course can break things.  (They should be changing the
number of UARTs in their board-support files).


Regards,
  Andrew Victor


