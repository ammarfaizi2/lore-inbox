Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUIWT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUIWT4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUIWT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:56:30 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:44979 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264953AbUIWT42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:56:28 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mikhail Ramendik <mr@ramendik.ru>
Subject: Re: 2.6.8.1, USB , "IRQ 11 disabled" on plugging in a device
Date: Thu, 23 Sep 2004 13:56:25 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409230959.19570.bjorn.helgaas@hp.com> <1095963910.2674.4.camel@localhost.localdomain>
In-Reply-To: <1095963910.2674.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231356.25420.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 12:25 pm, Mikhail Ramendik wrote:
> Bjorn Helgaas wrote:
> > > When I plug in a USB device it is not recognized. It does not even
> > > appear in lsusb. And it says that it disables IRQ 11 - which is even 
> > > NOT the IRQ used by USB!
> > 
> > Does it make any difference if you boot with "pci=routeirq"?
> 
> No. The behaviour is the same. Perhaps the message is somewhat
> different, but the "IRQ 11 disabled" part is still there.

Sorry, I wasn't paying enough attention.  You said you were on
2.6.8.1, which doesn't have "pci=routeirq" in it.  So of course
it didn't make any difference.  I was thinking you were on an
-mm kernel, where there are a couple issues that can be worked
around with "pci=routeirq".
