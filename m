Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVDVSRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVDVSRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVDVSRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 14:17:40 -0400
Received: from mail03.powweb.com ([66.152.97.36]:44304 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S262102AbVDVSRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 14:17:38 -0400
From: Richard Drummond <evilrich@rcdrummond.net>
Organization: Private
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Clean-up and bug fix for tdfxfb framebuffer size detection
Date: Fri, 22 Apr 2005 13:17:36 -0500
User-Agent: KMail/1.7.2
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org
References: <200504212309.12407.evilrich@rcdrummond.net> <4268BA5B.5020507@tebibyte.org>
In-Reply-To: <4268BA5B.5020507@tebibyte.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504221317.36902.evilrich@rcdrummond.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris

On Friday 22 April 2005 03:48 am, Chris Ross wrote:
> I /do/ have the hardware, so I am very glad to see someone working on
> support for the Voodoo 5.

I am glad somebody is interested. ;-)

> Are there any specific tests you would like me 
> to perform and send you the results from?

It's quite simple really. With this patch, does tdfxfb report the right amount 
of framebuffer memory for your card? The method it used to determine the 
amount of memory for the Voodoo4/5 before was wrong. If it gave the right 
value before, then it was probably just a coincidence.

Cheers,
Rich
