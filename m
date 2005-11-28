Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVK1UGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVK1UGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVK1UGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:06:16 -0500
Received: from main.gmane.org ([80.91.229.2]:30653 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932226AbVK1UGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:06:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: nvidia fb flicker
Date: Mon, 28 Nov 2005 20:57:57 +0100
Message-ID: <1drow6iat7zy8.2rt89nl7eodg.dlg@40tude.net>
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-207-209.42-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005 11:35:54 +0100, Marc Koschewski wrote:

> * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
> 
>> [12 quoted lines suppressed]
> 
> Hi all,
> 
> yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
> with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
> work (the source states GeForce2 Go is supported and known). However, the
> letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
> more like the sinle dots a letter is made of seem to randomly turn on an off. I
> one takes a closer look it seems like the whole screen is 'fluent' or something.
> Does anybody know how to handle that? I didn't specify a video mode, but
> 'video=vesafb:mtrr:3'. 

Let me guess ... you have a Dell Inspiron 8200 or some such? You must
compile nvidiafb without support for DDC.

(Antonio, any news on disabling DDC from the command line? like a
noddc option or some such?)

-- 
Giuseppe "Oblomov" Bilotta

Hic manebimus optime

