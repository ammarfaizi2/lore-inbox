Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTLBXpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTLBXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:45:34 -0500
Received: from relay-6m.club-internet.fr ([194.158.104.45]:12741 "EHLO
	relay-6m.club-internet.fr") by vger.kernel.org with ESMTP
	id S264452AbTLBXp0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:45:26 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nathans@sgi.com
Subject: Re: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Wed,  3 Dec 2003 00:45:21 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1070408721.1371.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




----Message d'origine----
>Date: Mon, 1 Dec 2003 16:36:33 -0800 (PST)
>De: Linus Torvalds <torvalds@osdl.org>
>A: pinotj@club-internet.fr
>Copie à: manfred@colorfullife.com, Andrew Morton <akpm@osdl.org>,
>Sujet: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
>
>
>
>On Sat, 29 Nov 2003 pinotj@club-internet.fr wrote:
>>
>> I triggered the slab oops with a very small kernel -test11 (~700KB):
>
>The only thing that looks at _all_ likely to explain the problem is
>
>> CONFIG_XFS_FS=y
>
>since there aren't that many XFS users I know of. It's also now the only
>thing that uses buffer heads in your config, so..
>
>I assume it's not an option to try another filesystem on this setup, but
>it's entirely possible that the 2.6.x buffer-head removal has impacted XFS
>negatively - although I'm a bit surprised at how easily you seem to show
>problems, since XFS actually has active maintenance.
[...]

Yes, I use XFS with my LFS but I got some problem with my slack on ext3 too. Usually under X and settings are not so good for debugging so I didn't made bug reports (nvidia driver too). I will try to confirm the problem under ext3.

Jerome

