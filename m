Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTFPVok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTFPVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:44:40 -0400
Received: from aibn55.astro.uni-bonn.de ([131.220.96.55]:50119 "EHLO
	aibn55.astro.uni-bonn.de") by vger.kernel.org with ESMTP
	id S264372AbTFPVoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:44:37 -0400
Date: Mon, 16 Jun 2003 23:58:25 +0200 (CEST)
From: Ole Marggraf <marggraf@astro.uni-bonn.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
In-Reply-To: <1055800323.586.0.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.55.0306162353560.3503@aibn99.astro.uni-bonn.de>
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
 <1055800323.586.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Felipe Alfaro Solana wrote:

> On Mon, 2003-06-16 at 20:51, Ole Marggraf wrote:
> > Hello all.
> >
> > As it seems (to me), there is some serious problem in the NFS code of
> > 2.4.21 (and also of 2.4.20), causing I/O errors quite immediately.
>
> By the way, are you using the "soft" option to mount the NFS volumes?
>

Hello.

Yes, forgot to mention... But its quite clear from the error message.

Mount options are rw,soft,bw,rsize=8192,wsize=8192.

And, as I wrote somewhere else, increasing retrans to 20 helps, which is
quite far from the default (default retrans=3 did work under 2.4.19).

Best regards,

Ole

-- 
+------------------------------------------------------------------------------+
 Ole Marggraf                     email: marggraf@gmx.net
 Sternwarte, Universitaet Bonn           marggraf@astro.uni-bonn.de
 Auf dem Huegel 71
 D-53121 Bonn, Germany            WWW:   http://www.astro.uni-bonn.de/~marggraf
+------------------------------------------------------------------------------+
