Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRKDTcn>; Sun, 4 Nov 2001 14:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKDTcd>; Sun, 4 Nov 2001 14:32:33 -0500
Received: from ns.suse.de ([213.95.15.193]:53257 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274368AbRKDTcU> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 14:32:20 -0500
Date: Sun, 4 Nov 2001 20:32:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011104202034.M14001@unthought.net>
Message-ID: <Pine.LNX.4.30.0111042030360.15260-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Jakob Østergaard wrote:

> Now this isn't even bad - the fun begins when a resync is running, when
> mdstat contains *progress meters* like  "[====>      ] 42%".  While being
> nicely readable for a human, this is a parsing nightmare.  Especially
> because stuff like this changes over time.

Any program needing to parse this would just ignore the bits between [],
and convert the percentage to an int. Hardly a 'nightmare'.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


