Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTIXXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTIXXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:12:26 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:44180 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261590AbTIXXMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:12:25 -0400
Date: Thu, 25 Sep 2003 01:12:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030924231202.GC5915@louise.pinerecords.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8708@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8708@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [len.brown@intel.com]
> 
> I'm not sure how to address "compatibility" and "regression" concepts in
> the face of changing config files.  Make oldconfig will ask you about
> CONFIG_ACPI -- perhaps I should update the help text to emphasize that
> it is necessary for HT, and that if selected, CONFIG_ACPI_HT_ONLY is
> then available?

Hmm, I happen to know of a system that fails to detect the sibling CPU(s)
with CONFIG_ACPI_HT_ONLY set, whereas w/o it "all fine running's."

Is this a bug?

-- 
Tomas Szepe <szepe@pinerecords.com>
