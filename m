Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132861AbRDDR3G>; Wed, 4 Apr 2001 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDDR24>; Wed, 4 Apr 2001 13:28:56 -0400
Received: from raven.toyota.com ([63.87.74.200]:13075 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S132861AbRDDR2m>;
	Wed, 4 Apr 2001 13:28:42 -0400
Message-ID: <3ACB59A0.C8B833C0@lexus.com>
Date: Wed, 04 Apr 2001 10:28:00 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khyron <khyron@khyron.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: loopback mount won't umount on 2.2.12
In-Reply-To: <Pine.BSF.4.33.0104040200340.86240-100000@four.malevolentminds.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khyron wrote:

> Okay, I've seen various references to problems with loopback
> mounts under (early) 2.2.x kernels. But I don't see any reference
> to a solution (ie. how to umount the stupid thing).
>
> My situation is that I have mounted a CD image on a machine
> for use in kickstart builds. The mount point is /kickstart/image
>
> When I attempt "umount /kickstart/image" and other variations
> on the theme, I get a "umount: /kickstart/image: device is busy".

Is it nfs exported?

If so, unexport it first.

cu

Jup

