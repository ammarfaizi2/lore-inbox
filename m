Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHNgT>; Thu, 8 Feb 2001 08:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131266AbRBHNf7>; Thu, 8 Feb 2001 08:35:59 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:36621 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S129486AbRBHNfw>; Thu, 8 Feb 2001 08:35:52 -0500
Date: Thu, 8 Feb 2001 05:35:31 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DNS goofups galore...
In-Reply-To: <20010208150632.K15688@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.32.0102080529580.19696-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Matti ,

On Thu, 8 Feb 2001, Matti Aarnio wrote:
 ...snip...
> Answer to the self-education question above:
>
>   The NAME fields in usual BIND systems get appended the current $ORIGIN
>   string value when the data in the field does not end with a dot:
>
>   Wrong:     IN MX 10  11.22.33.44
>   "Right":   IN MX 10  11.22.33.44.
    s/"Right"/Wrong/

	(in the forward file)
	Right:				IN MX 10  mymail.mydomain.com.
	Right:mymail.mydomain.com.	IN A	11.22.33.44

	(in a in-addr.arpa file)
	Right:44	IN PTR	mymail.mydomain.com.

>   The second appears at DNS lookup as "IN MX 10 11.22.33.44", which
>   is the intention aiming to use quite common misfeatures of system
>   libraries.  THERE IS NO GUARANTEE OF IT WORKING AT NON-UNIX SYSTEMS!
>   Indeed there is no guarantee of it working at UNIX systems either!
	True ! .	Hth ,  JimL

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
