Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTL2QOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTL2QOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:14:17 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:56448 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263639AbTL2QOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:14:12 -0500
From: Duncan Sands <baldrick@free.fr>
To: "Guldo K" <guldo@tiscali.it>
Subject: Re: speedtouch for 2.6.0
Date: Mon, 29 Dec 2003 17:14:10 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <16366.61517.501828.389749@gargle.gargle.HOWL> <200312291334.01173.baldrick@free.fr> <16368.19971.604371.882502@gargle.gargle.HOWL>
In-Reply-To: <16368.19971.604371.882502@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312291714.10152.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But when I ran pppd, I got:
> pppd: /usr/lib/pppd/plugins/pppoatm.so:
>  cannot open shared object file: No such file or directory
> pppd: Couldn't load plugin /usr/lib/pppd/plugins/pppoatm.so
>
> I looked for it and noticed it was in /usr/lib/pppd/2.4.20/,
> so I linked it; but then I got:
> pppd: libatm.so.1: cannot open shared object file: No such file or
> directory pppd: Couldn't load plugin /usr/lib/pppd/plugins/pppoatm.so
>
> Looks like I missed some piece of installation...
>
> Could you help me?

Hi Guldo, from your email I had understood that your setup worked under
2.4.  Is that right?  Then it should work under 2.6.  Anyway, the speedbundle (
http://linux-usb.sourceforge.net/SpeedTouch/download/index.html
) contains source code for an appropriate pppd + ATM library.

Ciao,

Duncan.
