Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTFPVup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTFPVuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:50:44 -0400
Received: from aibn55.astro.uni-bonn.de ([131.220.96.55]:56263 "EHLO
	aibn55.astro.uni-bonn.de") by vger.kernel.org with ESMTP
	id S264374AbTFPVuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:50:44 -0400
Date: Tue, 17 Jun 2003 00:04:32 +0200 (CEST)
From: Ole Marggraf <marggraf@astro.uni-bonn.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
In-Reply-To: <Pine.LNX.4.55.0306162353560.3503@aibn99.astro.uni-bonn.de>
Message-ID: <Pine.LNX.4.55.0306170001320.3565@aibn99.astro.uni-bonn.de>
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
 <1055800323.586.0.camel@teapot.felipe-alfaro.com>
 <Pine.LNX.4.55.0306162353560.3503@aibn99.astro.uni-bonn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > By the way, are you using the "soft" option to mount the NFS volumes?
> >
>
> Yes, forgot to mention... But its quite clear from the error message.
>
> Mount options are rw,soft,bw,rsize=8192,wsize=8192.

Ok, correction. (I should go home and get some sleep...)
rsize=8192,wsize=8192 were not set in the original testing setup, I had
the defaults there (1024 both). The amount of bytes written till the I/O
error gets up does scale with that option.

Ole

-- 
+------------------------------------------------------------------------------+
 Ole Marggraf                     email: marggraf@gmx.net
 Sternwarte, Universitaet Bonn           marggraf@astro.uni-bonn.de
 Auf dem Huegel 71
 D-53121 Bonn, Germany            WWW:   http://www.astro.uni-bonn.de/~marggraf
+------------------------------------------------------------------------------+
