Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTJAGn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTJAGn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:43:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23177 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262001AbTJAGnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:43:25 -0400
Date: Tue, 30 Sep 2003 23:39:25 -0700
From: "David S. Miller" <davem@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: bunk@fs.tum.de, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930233925.022f3194.davem@redhat.com>
In-Reply-To: <20030930150430.GA2996@conectiva.com.br>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030928233909.GG1039@conectiva.com.br>
	<20030929001439.GY15338@fs.tum.de>
	<20030929003229.GM1039@conectiva.com.br>
	<20030929221129.7689e088.davem@redhat.com>
	<20030930133729.GJ295@fs.tum.de>
	<20030930150430.GA2996@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 12:04:31 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> And just for the record, as a matter of taste I'd like to see all #ifdefs in
> structs to disappear, look at what I did to struct sock in 2.5 and look at
> struct sock (include/net/sock.h) in 2.4: no #ifdefs where there was a ton,

I totally agree with this.  It would make the structs that actually
get used smaller in fact.
