Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270764AbTGNUXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270774AbTGNUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:14:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7108
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270808AbTGNULB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:11:01 -0400
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David griego <dagriego@hotmail.com>, alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F130C75.3010603@pobox.com>
References: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
	 <3F130C75.3010603@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058214188.606.139.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 21:23:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 21:03, Jeff Garzik wrote:
> If the host CPU is a bottleneck after large-send and checksums have been 
> offloaded, then logically you aren't getting any work done _anyway_. 
> You have to interface with the net stack at some point, in which case 
> you incur a fixed cost, for socket handling, TCP exception handling, etc.
> 
> Maybe somebody needs to be looking into AMP (asymmetric 
> multiprocessing), too.

There isnt currently any evidence it buy you anything, although HT may
change that equation a bit. Its still the same RAM bandwidth and you've
not really gotten rid of most of the socket handling/event/wakeup
overhead either.

