Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSJVWZm>; Tue, 22 Oct 2002 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJVWZm>; Tue, 22 Oct 2002 18:25:42 -0400
Received: from rth.ninka.net ([216.101.162.244]:15505 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264944AbSJVWZl>;
	Tue, 22 Oct 2002 18:25:41 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: "David S. Miller" <davem@rth.ninka.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Slavcho Nikolov <snikolov@okena.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021022211535.GZ1111@mea-ext.zmailer.org>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K> 
	<20021022211535.GZ1111@mea-ext.zmailer.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 15:42:39 -0700
Message-Id: <1035326559.16085.18.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 14:15, Matti Aarnio wrote:
>   ftp://zmailer.org/linux/netif_rx.patch

Please EXPORT_GPL this, if you are going to do it at all.

Only non-GPL compliant binary-modules can result from this
change.

People can easily do things like implement their own entire
networking stack with this hook, which is not what we want nor
is it allowed.

