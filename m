Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTHLRmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbTHLRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:42:42 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:15072 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S270847AbTHLRml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:42:41 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@papp.hu>
Subject: Re: PPPoE Oops with 2.4.22-rc
References: <5ff3.3f388c4b.4453f@gzp1.gzp.hu> <Pine.LNX.4.44.0308121415540.10199-100000@logos.cnet>
Organization: Who, me?
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.22-rc2-gzp1 (i686))
Message-ID: <1278.3f39270f.39670@gzp1.gzp.hu>
Date: Tue, 12 Aug 2003 17:42:39 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:

|> The ksymoops output attached, more details at
|> http://gzp.odpn.net/tmp/linux-pppoe-oops/

[...]

|> EIP:    0010:[<e0ed9bce>]    Tainted: PF
| 
| Why is your kernel tainted?
| 
| Are you using stock 2.4.22-rc2 or do you have any additional 
| patches/modules running? 

Stock 2.4.22-rc2 with alsa, and I'm using a binary only
module for my webcam from http://www.smcc.demon.nl/webcam/

BUT, I'm getting the oopses *without* the module loaded in.
Its loaded at startup, thats why tainted later.

I can reproduce the oops all the time, with or without the module.

