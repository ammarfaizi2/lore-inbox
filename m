Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTFMJAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTFMJAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:00:15 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:7443 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S265276AbTFMJAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:00:14 -0400
Date: Fri, 13 Jun 2003 11:14:00 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613091400.GB78853@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:40:37AM +0100, Alan Cox wrote:
> Dave Miller posted a simple patch to allow netlink to be used for
> kernel->user messages - hotplug/disk error/logging/whatever. I'm
> suprised therefore that the whole thing is being regurgitated again.

"Netlink is not a reliable protocol." sez the manpage.

That sounds a little ridiculous for a local kernel<->user message
protocol.  Having to manage acks on that kind of communication is both
painful and quasi-untestable.

  OG.
