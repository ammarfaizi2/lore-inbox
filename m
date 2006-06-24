Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFXWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFXWnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWFXWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:43:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751143AbWFXWnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:43:12 -0400
Message-ID: <449DBFFD.2010700@garzik.org>
Date: Sat, 24 Jun 2006 18:43:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: castet.matthieu@free.fr, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org>
In-Reply-To: <449DBE88.5020809@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Data point #3 (or #0...):

This appears to be a _device_ that sends its interrupt early.

If that is the case, the device may appear on any controller, not just 
VIA, and we would have to handle it globally via a device special-case 
in libata-core.

	Jeff



