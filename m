Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbULGDa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbULGDa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbULGDa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:30:57 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:31414 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261712AbULGDax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:30:53 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041207032438.GA7767@soohrt.org>
References: <20041206224107.GA8529@soohrt.org>
	 <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
	 <20041207002012.GB30674@quickstop.soohrt.org>
	 <1102387595.1088.48.camel@jzny.localdomain>
	 <20041207025456.GA525@soohrt.org>
	 <1102389533.1089.51.camel@jzny.localdomain>
	 <20041207032438.GA7767@soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102390241.1093.59.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Dec 2004 22:30:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 22:24, Karsten Desler wrote:
> roller (rev 03)
> 
> driver: e1000
> version: 5.5.4-k2-NAPI
> firmware-version: N/A
> bus-info: 0000:01:03.0
> 
> driver: e1000
> version: 5.5.4-k2-NAPI
> firmware-version: N/A
> bus-info: 0000:01:01.0

Beats me. Make sure it boots NAPI. Also if you can turn off ITR; intel
loves to turn on that silly feature.


cheers,
jamal

