Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbULGNPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbULGNPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbULGNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:15:04 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:30922 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261805AbULGNOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:14:55 -0500
Date: Tue, 7 Dec 2004 14:14:45 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: jamal <hadi@cyberus.ca>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207131445.GA1622@soohrt.org>
References: <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net> <20041207002012.GB30674@quickstop.soohrt.org> <1102387595.1088.48.camel@jzny.localdomain> <20041207025456.GA525@soohrt.org> <1102389533.1089.51.camel@jzny.localdomain> <20041207032438.GA7767@soohrt.org> <1102390241.1093.59.camel@jzny.localdomain> <20041207040235.GA10501@soohrt.org> <20041207102132.GA28588@quickstop.soohrt.org> <1102422845.1089.105.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1102422845.1089.105.camel@jzny.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal wrote:
> > # sar -I 169 5 5
> > 11:20:05         INTR    intr/s
> > 11:20:10          169  10401.40
> 
> That doesnt seem to be too high. 

To recap: 169 is a fibre e1000, eth1 is one of two ports on a dualport
e1000 copper nic. eth1 is still running at about 4k int/s.

14:12:18         INTR    intr/s
14:12:23          169  34012.80
14:12:28          169  33977.60
14:12:33          169  34218.16
14:12:38          169  34060.60
14:12:43          169  34252.60
Average:          169  34104.40

Cheers,
 Karsten
