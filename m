Return-Path: <linux-kernel-owner+w=401wt.eu-S1751295AbXAIKh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXAIKh2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXAIKh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:37:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33532 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXAIKh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:37:28 -0500
Message-ID: <45A37065.10207@pobox.com>
Date: Tue, 09 Jan 2007 05:37:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, uwe.koziolek@gmx.net
Subject: Re: [PATCH] sata_sis: Support for PATA supports
References: <20070108161107.121f196b@localhost.localdomain>
In-Reply-To: <20070108161107.121f196b@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This is quick rework of the patch Uwe proposed but using Kconfig not
> ifdefs and user selection to sort out PATA support. Instead of ifdefs and
> requiring the user to select both drivers the SATA driver selects the
> PATA one.
> 
> For neatness I've also moved the extern into the function that uses it.
> 
> Two questions really
> 1.	Do you want the extern in a header file
> 2.	Is this now neat enough to keep you happy Jeff or shall I do
> the library split anyway ?
> 
> Please let me know so I can fire off new versions and try and get
> this one submitted for good today.
> 
> Signed-off-by: Alan Cox

I ACK this patch, as mentioned earlier, but the description and sign-off 
leave something to be desired.

Would you rather resend this patch without all the commentary, so that 
it may be automatically snarfed, or just resend a proper description and 
sign-off?

Note that (as stated in Documentation/SubmittingPatches) the standard 
way to include commentary is to include it after the patch description 
and "---" separator.  Anything after "---" is automatically snipped.

This applies to patches sent to Linus, me, and anyone else who uses git 
to import patches.  (as well as being the patch format standard)

	Jeff



