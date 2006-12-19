Return-Path: <linux-kernel-owner+w=401wt.eu-S1754799AbWLSLWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbWLSLWM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbWLSLWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:22:11 -0500
Received: from trinity.fluff.org ([217.147.94.151]:2253 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbWLSLWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:22:10 -0500
X-Greylist: delayed 2312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 06:22:10 EST
Date: Tue, 19 Dec 2006 10:43:35 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Wim Van Sebroeck <wim@iguana.be>, Ben Dooks <ben@simtec.co.uk>,
       Dimitry Andric <dimitry.andric@tomtom.com>
Subject: Re: [PATCH] watchdog: fix clk_get() error check
Message-ID: <20061219104335.GG11640@trinity.fluff.org>
References: <20061219085144.GI4049@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085144.GI4049@APFDCB5C>
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 05:51:44PM +0900, Akinobu Mita wrote:
> The return value of clk_get() should be checked by IS_ERR().

thanks for spotting this, but this will probably clash with
a cleanup patch I sent a day or two ago to streamline the
exit path in the driver.

see http://lkml.org/lkml/2006/12/18/65

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

