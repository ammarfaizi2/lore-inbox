Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129180AbRBML2h>; Tue, 13 Feb 2001 06:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRBML22>; Tue, 13 Feb 2001 06:28:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44296 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130497AbRBML1w>; Tue, 13 Feb 2001 06:27:52 -0500
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Tue, 13 Feb 2001 11:22:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        carlos@fisica.ufpr.br (Carlos Carvalho), linux-kernel@vger.kernel.org
In-Reply-To: <shslmra9a9f.fsf@charged.uio.no> from "Trond Myklebust" at Feb 13, 2001 10:56:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SdXQ-0001Ts-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> volunteer to backport all the `safe' definitions from 2.4.x) would be
> to add the generic `*(int *)0 = 0' definition for local use by ping()
> itself.

*(int *)0 doesnt work for all ports either

I'd rather let people suffer a little and fix BUG  8)

