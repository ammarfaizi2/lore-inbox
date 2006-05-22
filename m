Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWEVVFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWEVVFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEVVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:05:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28367 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750754AbWEVVFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:05:19 -0400
Message-ID: <44722756.5090902@zytor.com>
Date: Mon, 22 May 2006 14:04:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605222200.18351.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> 
> I would, but if it's a "valid concern" that gzip is a few hundred KB larger, 
> and the community would not graciously receive such work, there's not much 
> point, is there? :-)
> 
> Seriously, though, if I understand gzip correctly, it uses deflate/zlib 
> internally. Why, in that case, does /bin/gzip not (dynamically) link against 
> libz? If a first step was fixing that, a second could be linking dynamically 
> against libbz2 and 'liblzma', and making it all compile-time configurable.
> 

Because gzip predates zlib...

	-hpa
