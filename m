Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWJEUhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWJEUhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJEUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:37:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:21676 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751279AbWJEUhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:37:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] net/ipv6: seperate sit driver to extra module
References: <20061005154152.GA2102@zlug.org> <Pine.LNX.4.64.0610051148230.23631@d.namei>
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Thu, 05 Oct 2006 22:33:22 +0200
Message-ID: <E1GVZuE-0003e9-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks ok to me, although given that users used to get this by default when
> selecting IPv6, perhaps the default in Kconfig should be y.

Yes, and the fact that the easiest way to get IPv6 connectivity [1] needs
this driver suggests defaulting to yes (and changing the "if unsure..."
wording) too.

Olaf

[1] see RFC 3056, RFC 3068; http://sites.inka.de/bigred/sw/6to4

