Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWJWIYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWJWIYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWJWIYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:24:11 -0400
Received: from ns.firmix.at ([62.141.48.66]:11241 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751815AbWJWIYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:24:09 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Bernd Petrovitsch <bernd@firmix.at>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 23 Oct 2006 10:24:06 +0200
Message-Id: <1161591846.12449.4.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.397 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-22 at 22:41 -0700, Giridhar Pemmasani wrote:
> It seems that the kernel module loader taints ndiswrapper module as
> proprietary, but it is not - it is fully GPL: see
> http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html
> 
> Note that when a driver is loaded, ndiswrapper does taint the kernel (to be
> more accurate, it should check if the driver being loaded is GPL or not, but
> that is not done).

There is no reason (apart from "it hasn't been done yet2 which is a very
weak reason) to use ndiswrapper with a GPL-module - just port the
GPL-module over.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

