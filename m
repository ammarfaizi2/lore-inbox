Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTFMI3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTFMI3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:29:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:944
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265258AbTFMI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:29:17 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Greg KH <greg@kroah.com>, sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612150335.6710a94f.akpm@digeo.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com>
	 <20030612150335.6710a94f.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 09:40:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-12 at 23:03, Andrew Morton wrote:
> This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
> very interested in reading an outline of how you propose fixing it, without
> waiting until OLS, thanks.

Dave Miller posted a simple patch to allow netlink to be used for
kernel->user messages - hotplug/disk error/logging/whatever. I'm
suprised therefore that the whole thing is being regurgitated again.


