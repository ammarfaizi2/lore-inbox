Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVGGPQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVGGPQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGGPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:16:34 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:53005 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S262103AbVGGPPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:15:18 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: Andrew Victor <andrew@sanpeople.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <1120747271.19467.388.camel@hades.cambridge.redhat.com>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <1120747271.19467.388.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1120749256.16806.146.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Jul 2005 17:14:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi David,

> > +// -  Redistributions in binary form must reproduce the above copyright notice,
> > +// this list of conditions and the disclaimer below in the documentation and/or
> > +// other materials provided with the distribution.
> 
> Is that for real?

The hardware headers can't be GPL since they're also used on other
non-Linux systems.  The best we can probably get is a BSD-style license.

Regarding the actual wording, try:
  grep -r "Redistributions in binary form" * | grep -v minimum

I count 130 instances of the same requirement in 2.6.13-rc2, though some
of the files are dual-licensed.


Regards,
  Andrew Victor


