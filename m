Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbQLNCNo>; Wed, 13 Dec 2000 21:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbQLNCNe>; Wed, 13 Dec 2000 21:13:34 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:58385 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S131712AbQLNCNU>;
	Wed, 13 Dec 2000 21:13:20 -0500
Date: Wed, 13 Dec 2000 17:43:08 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Lennert Buytenhek <buytenh@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bsd-style cursor
In-Reply-To: <Pine.LNX.4.30.0012140043170.17218-100000@mara.math.leidenuniv.nl>
Message-ID: <Pine.LNX.4.21.0012131742001.901-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> included a patch against 2.4.0-test9 (should apply against latest but
> haven't checked) which adds the config option to have a bsd-style cursor
> in VT's by default. I was hoping it might be considered for inclusion so
> that I don't have to patch it in myself every time :-)

How about placing  

   echo '\033[?17;120c'  

In one of your startup scripts. This will give you this nice BSD cursor
you like.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
