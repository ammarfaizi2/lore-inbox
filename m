Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWEWNhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWEWNhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEWNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:37:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7356 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932139AbWEWNhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:37:35 -0400
Date: Tue, 23 May 2006 15:37:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <44722756.5090902@zytor.com>
Message-ID: <Pine.LNX.4.61.0605231537040.25086@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk>
 <44722756.5090902@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Seriously, though, if I understand gzip correctly, it uses deflate/zlib
>> internally. Why, in that case, does /bin/gzip not (dynamically) link
>> against libz? If a first step was fixing that, a second could be linking
>> dynamically against libbz2 and 'liblzma', and making it all compile-time
>> configurable.
>
> Because gzip predates zlib...
>
So we are carrying cruft around.


Jan Engelhardt
-- 
