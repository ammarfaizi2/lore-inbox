Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbULGCzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbULGCzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 21:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULGCzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 21:55:05 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:25800 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261743AbULGCzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 21:55:00 -0500
Date: Tue, 7 Dec 2004 03:54:56 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: jamal <hadi@cyberus.ca>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207025456.GA525@soohrt.org>
References: <20041206224107.GA8529@soohrt.org> <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net> <20041207002012.GB30674@quickstop.soohrt.org> <1102387595.1088.48.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1102387595.1088.48.camel@jzny.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal wrote:
> 
> Your numbers are very suspect. You may be having other issues in the
> box. You should be able to do much higher packet rates even with
> iptables compiled in.

I know, and I have no idea why I'm not.

> Some numbers at:
> 
> http://www.suug.ch/sucon/04/slides/pkt_cls.pdf
> 
> If all you need is std filtering then consider using tc actions.

Thanks, I'll look into it.

> I do have a suspicion that your problem has to do with your machine
> more than it does with Linux.

But what could be the reason? I'm really out of ideas.
The only thing I can think off is the 66/64 PCI bus and the
disadvantageous placement of the PCI cards, but neither should cause a
higher CPU usage. If the bus couldn't keep up, I'd get packetloss.

- Karsten
