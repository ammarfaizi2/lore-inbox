Return-Path: <linux-kernel-owner+w=401wt.eu-S932958AbWLSVVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbWLSVVC (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933002AbWLSVVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:21:01 -0500
Received: from outmx017.isp.belgacom.be ([195.238.4.116]:60488 "EHLO
	outmx017.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958AbWLSVVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:21:00 -0500
Date: Tue, 19 Dec 2006 22:20:34 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Ben Dooks <ben@simtec.co.uk>,
       Dimitry Andric <dimitry.andric@tomtom.com>
Subject: Re: [PATCH] watchdog: fix clk_get() error check
Message-ID: <20061219212034.GB2943@infomag.infomag.iguana.be>
References: <20061219085144.GI4049@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085144.GI4049@APFDCB5C>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu,

> The return value of clk_get() should be checked by IS_ERR().

Modified patch added to linux-2.6-watchdog-mm git tree.
(I needed to modify the s3c2410_wdt.c part since because of the
changes we added yesterday).

Greetings,
Wim.

