Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTF0Pcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTF0Pcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:32:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46726
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264453AbTF0Pcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:32:48 -0400
Subject: Re: bkbits.net is down
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030627145727.GB18676@work.bitmover.com>
References: <20030621135812.GE14404@work.bitmover.com>
	 <20030621190944.GA13396@work.bitmover.com>
	 <20030622002614.GA16225@work.bitmover.com>
	 <20030623053713.GA6715@work.bitmover.com>
	 <20030625013302.GB2525@work.bitmover.com> <20030626231752.E5633@ucw.cz>
	 <20030626212102.GA19056@work.bitmover.com>
	 <1056711200.3174.23.camel@dhcp22.swansea.linux.org.uk>
	 <20030627145727.GB18676@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056728645.3174.48.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 16:44:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 15:57, Larry McVoy wrote:
> Is there a PCI EIDE card that you could suggest that would be ultra stable?
> Or should I just toss this box and go build up another one?

PCI ones tend to be the most problematic. The on board CSB5/CSB6 should be
very reliable. Failing that you really get to choose between promise, highpoint
and SI (SI/CMD680). The CMD680 driver has had a few problems compared with the
others but docs exist under NDA. I'd use the onboard IDE

