Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTE0Rdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTE0Rdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:33:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17358
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263970AbTE0Rds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:33:48 -0400
Subject: Re: Linux 2.5.70
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054054133.18814.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 17:48:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-27 at 18:26, Linus Torvalds wrote:
> On Tue, 27 May 2003, Ricky Beam wrote:
> > 
> > Count up the number of drivers that haven't been updated to the current
> > PCI, hotplug, and modules interfaces.
> 
> Tough. If people don't use them, they don't get supported. It's that easy.

Its also a lot easier to update them once the core stops changing! There
are some things I worry about - the bio splitting has to be resolved,
IDE raid can't happen until that occurs and I'm also waiting for the IDE
taskfile stuff/bio splitting bits to resolve so I can merge a load of
IDE updates to make things like SII IDE and newer HPT chips work in
2.5.x/2.6

Architectures are also normally just a sync up job and its again easier
to do once the core has stoppee changing.

