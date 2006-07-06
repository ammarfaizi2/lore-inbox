Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWGFOmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWGFOmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGFOml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:42:41 -0400
Received: from khc.piap.pl ([195.187.100.11]:12489 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030297AbWGFOml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:42:41 -0400
To: Robert Hancock <hancockr@shaw.ca>
Cc: earthquake.de@freenet.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to reset pci device
References: <1152172405.112420.80940@m73g2000cwd.googlegroups.com>
	<44AD1D81.9000907@shaw.ca>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 06 Jul 2006 16:42:36 +0200
In-Reply-To: <44AD1D81.9000907@shaw.ca> (Robert Hancock's message of "Thu, 06 Jul 2006 08:26:09 -0600")
Message-ID: <m3mzbmiylf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock <hancockr@shaw.ca> writes:

> If you mean issuing a reset to that specific device, there is no
> portable way to do this, if there is any way at all. In most cases
> it's likely impossible to reset just one device on the PCI bus.

It's different if you're writing a driver for such device - it doesn't
have to be "portable", and many (all?) PCI glue chips can be reset (and
can reset the rest of stuff on the card) by writing to a special (bit)
register.
-- 
Krzysztof Halasa
