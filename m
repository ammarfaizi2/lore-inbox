Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129502AbRCAE0T>; Wed, 28 Feb 2001 23:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCAE0J>; Wed, 28 Feb 2001 23:26:09 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:29208 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S129502AbRCAEZt>;
	Wed, 28 Feb 2001 23:25:49 -0500
Date: Wed, 28 Feb 2001 21:25:47 -0700 (MST)
From: Todd <todd@unm.edu>
To: Hans Reiser <reiser@namesys.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <3A9D891C.434E3AA7@namesys.com>
Message-ID: <Pine.A41.4.33.0102282123180.68876-100000@aix09.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hans,

we've found that the TCP and UDP performance on 2.4 is *dramatically*
better than 2.2.  with the acenic gig-e driver on PIII-933 UP (66MHz x
64bits PCI) we are getting 993 Mb/s with 2.4.0 with jumbo frames (about
850 Mb/s with standard ethernet frames).  the best number we got with 2.2
was about 650 with jumbos and 550 with standard.

i'd recommend it's networking performance to anyone.

todd underwood
todd@unm.edu

On Thu, 1 Mar 2001, Hans Reiser wrote:

> Date: Thu, 01 Mar 2001 02:26:20 +0300
> From: Hans Reiser <reiser@namesys.com>
> To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: What is 2.4 Linux networking performance like compared to BSD?
>
> I have a client that wants to implement a webcache, but is very leery of
> implementing it on Linux rather than BSD.
>
> They know that iMimic's polymix performance on Linux 2.2.* is half what it is on
> BSD.  Has the Linux 2.4 networking code caught up to BSD?
>
> Can I tell them not to worry about the Linux networking code strangling their
> webcache product's performance, or not?
>
> Hans
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


