Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWETA6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWETA6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWETA6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:58:06 -0400
Received: from mail.siegenia-aubi.com ([217.5.180.129]:60561 "EHLO
	alg-1.siegenia-aubi.com") by vger.kernel.org with ESMTP
	id S1751454AbWETA6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:58:05 -0400
Message-ID: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com>
From: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>
To: "'Peter Gordon'" <codergeek42@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: RE: replacing X Window System !
Date: Sat, 20 May 2006 02:57:55 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Although one has to admit that working with remote X 
> terminals over a
> > SSH/WAN/VPN-connection is far from usefull, [...]
> You can tunnel just about anything X11 over SSH/VPN/etc.; even things
> like a whole desktop GUI; not just plain X terminals.

Did you actually do that? Starting Firefox over a 6 Mbit VPN takes about 3
minutes on a FAST machine. That´s not acceptable - our users want (almost)
immediate response to an application, to clicking and waiting 10 seconds
until the app is doing something.

> > However, there´s NX (http://www.nomachine.com/) and
> > other products but out of the box X11 it´s quite slow over 
> higher latency
> > connections.
> One good way to reduce latency (at least when using X11 over SSH) is
> to tell SSH to compress its connection tunnel ("ssh -C ...").
> 

Yes, this will start Firefox (as an example) down to 2 minutes 15 seconds
and put additional compression/decompression load on the system. We go for
AIP right now (Sun Secure Global Desktop), there you have the feeling as if
you were sitting in front of the box.


-- 
Markus
