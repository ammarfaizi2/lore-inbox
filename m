Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131952AbQLNCTh>; Wed, 13 Dec 2000 21:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbQLNCT1>; Wed, 13 Dec 2000 21:19:27 -0500
Received: from zada.math.leidenuniv.nl ([132.229.231.3]:37136 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S131952AbQLNCTR>; Wed, 13 Dec 2000 21:19:17 -0500
Date: Thu, 14 Dec 2000 02:49:05 +0100 (MET)
From: Lennert Buytenhek <buytenh@gnu.org>
To: James Simmons <jsimmons@suse.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bsd-style cursor
In-Reply-To: <Pine.LNX.4.21.0012131742001.901-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.30.0012140244260.17627-100000@mara.math.leidenuniv.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, James Simmons wrote:

> > included a patch against 2.4.0-test9 (should apply against latest but
> > haven't checked) which adds the config option to have a bsd-style cursor
> > in VT's by default. I was hoping it might be considered for inclusion so
> > that I don't have to patch it in myself every time :-)
>
> How about placing
>
>    echo '\033[?17;120c'
>
> In one of your startup scripts. This will give you this nice BSD
> cursor you like.

[buytenh@mara buytenh]$ tail -1 ~/.bash_profile
echo -e -n '\033[?17;127c'
[buytenh@mara buytenh]$

This has Issues though: try entering vi for example.

I'd just like a way of altering CUR_DEFAULT (which is hardcoded here and
there); sysctl would be fine too for that matter.


cheers,
Lennert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
