Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266644AbTGFI6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 04:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266649AbTGFI6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 04:58:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11682
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266644AbTGFI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 04:58:47 -0400
Subject: Re: 2.4.21 ServerWorks DMA Bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706090656.GA4739@louise.pinerecords.com>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
	 <87fzllh21i.fsf@gitteundmarkus.de>
	 <Pine.LNX.4.53.0307050956060.2029@mackman.net>
	 <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030706090656.GA4739@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 10:10:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 10:06, Tomas Szepe wrote:
> It doesn't all right. :)
> 
> On a G3 Compaq Proliant, all drives come up in PIO by default;
> DMA needs to be enabled by "/usr/sbin/hdparm -d1 -X69 /dev/hdX".

This is because your compaq BIOS decided to set it up this way.

