Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbULGECm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbULGECm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 23:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbULGECl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 23:02:41 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:40904 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261755AbULGECk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 23:02:40 -0500
Date: Tue, 7 Dec 2004 05:02:35 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: jamal <hadi@cyberus.ca>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207040235.GA10501@soohrt.org>
References: <20041206224107.GA8529@soohrt.org> <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net> <20041207002012.GB30674@quickstop.soohrt.org> <1102387595.1088.48.camel@jzny.localdomain> <20041207025456.GA525@soohrt.org> <1102389533.1089.51.camel@jzny.localdomain> <20041207032438.GA7767@soohrt.org> <1102390241.1093.59.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1102390241.1093.59.camel@jzny.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal wrote:
> Beats me. Make sure it boots NAPI. Also if you can turn off ITR; intel
> loves to turn on that silly feature.

ITR was in fact activated. I think i've disabled it now
(e1000.InterruptThrottleRate=0 in the kernel cmdline).
And as I'm reading the e1000 code, there is no way to enable/disable
NAPI without a recompile. So the fact that ethtool spat out -NAPI in
the version string means that NAPI is actually used.

- Karsten
