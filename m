Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbRFUTSU>; Thu, 21 Jun 2001 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbRFUTSB>; Thu, 21 Jun 2001 15:18:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42952 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265133AbRFUTRr>;
	Thu, 21 Jun 2001 15:17:47 -0400
Date: Thu, 21 Jun 2001 15:17:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
In-Reply-To: <sxMyWB.A.NBB.TYkM7@dinero.interactivesi.com>
Message-ID: <Pine.GSO.4.21.0106211513130.209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001, Timur Tabi wrote:

> In my opinion, this whole thing would just go away (including some of
> Microsoft's anti-GPL rants), if the FSF officially declared that under the GPL,
> #including a GPL header file does NOT force your code to be also GPL.

The problem being, there is no such thing as header file from C point of view.
I can do

cat >my_file.c <<EOF
#include "/home/you/your_file.c"
EOF

and be done with that. And yes, it's abusing cpp.

