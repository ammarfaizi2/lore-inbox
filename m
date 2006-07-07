Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWGGFeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWGGFeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGGFeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:34:03 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64719 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751185AbWGGFeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:34:02 -0400
Message-ID: <44ADF244.5050504@garzik.org>
Date: Fri, 07 Jul 2006 01:33:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6 libata stupid question...
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
In-Reply-To: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> There's only one minor detail - although the CD is (AFAIK) a UDMA/33 device,
> the hard drive and the controller are both able to do UDMA/100.

Currently both master and slave are forced to the least common 
denominator speed.

Alan Cox has fixed this in a patch, for the controllers that allow 
master and slave to run at different bus speeds (most allow this).

	Jeff


