Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVG1UoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVG1UoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVG1UgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:36:13 -0400
Received: from mulder.f5.com ([205.229.151.150]:28707 "EHLO mail.f5.com")
	by vger.kernel.org with ESMTP id S262228AbVG1Uev convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:34:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Why does CONFIG_MODVERSIONS turn off GPLONLY?
Date: Thu, 28 Jul 2005 13:34:46 -0700
Message-ID: <D21DA3C47E71114583C3EC4B0CCB9A9903EADE87@exchfive.olympus.f5net.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why does CONFIG_MODVERSIONS turn off GPLONLY?
Thread-Index: AcWTs8rU2YtEfhqtTVqFlzeCfcAuAA==
From: "Anthony King" <a.king@f5.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the 2.4 kernel, include/linux/module.h redefines EXPORT_SYMBOL_GPL to
__EXPORT_SYMBOL when CONFIG_MODVERSIONS is enabled.  This results in the
GPLONLY_ prefix being dropped from symbols requesting it.  Is this
intentional, or is it a bug?

Please CC: me in replies.


thanks,

- Anthony
