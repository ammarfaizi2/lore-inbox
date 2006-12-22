Return-Path: <linux-kernel-owner+w=401wt.eu-S1754831AbWLVNJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbWLVNJk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWLVNJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:09:40 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:59183 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbWLVNJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:09:39 -0500
Message-ID: <458BD945.5020604@gentoo.org>
Date: Fri, 22 Dec 2006 08:10:29 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Martin Williges <kernel@zut.de>
CC: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usblp.c - add Kyocera Mita FS 820 to list of "quirky"
 printers
References: <200612221227.18870.kernel@zut.de>
In-Reply-To: <200612221227.18870.kernel@zut.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Williges wrote:
> --- usblp.c.orig        2006-11-29 22:57:37.000000000 +0100
> +++ usblp.c     2006-12-22 12:08:00.000000000 +0100
> @@ -217,6 +217,7 @@ static const struct quirk_printer_struct

Your mailer has mangled tabs into whitespace. Also, your patch needs to 
be applicable with -p1 from the root kernel dir.

Given the description of the problem it is probably more worthwhile to 
provide logs with USB debugging enabled, and usbmon logs, so that the 
real problem can be found.

Daniel
