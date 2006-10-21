Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWJUTTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJUTTW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422827AbWJUTTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:19:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422822AbWJUTTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:19:21 -0400
Message-ID: <453A72B5.3000205@pobox.com>
Date: Sat, 21 Oct 2006 15:19:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] libata-sff: Allow for wacky systems
References: <1161012290.24237.68.camel@localhost.localdomain>
In-Reply-To: <1161012290.24237.68.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> There are some Linux supported platforms that simply cannot hit the low
> I/O addresses used by ATA legacy mode PCI mappings. These platforms have
> a window for PCI space that is fixed by the board logic and doesn't
> include the neccessary locations.
> 
> Provide a config option so that such platforms faced with a controller
> that they cannot support simply error it and punt
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


