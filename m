Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTIVRzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbTIVRzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:55:21 -0400
Received: from havoc.gtf.org ([63.247.75.124]:49578 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261345AbTIVRzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:55:19 -0400
Date: Mon, 22 Sep 2003 13:55:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030922175516.GA23397@gtf.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC86E1@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC86E1@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:28:03PM -0400, Brown, Len wrote:
> If somebody has a 2.4.22 system where CONFIG_ACPI_HT_ONLY plus zero
> cmdline parameters doesn't result in HT running and no ACPI running,
> then please forward the details directly to me.

The old acpitable.[ch] was unconditionally enabled...  So _not_
unconditionally enabling HT was a regression.

(just pointing out a fact;  I actually prefer a CONFIG_xxx)

	Jeff



