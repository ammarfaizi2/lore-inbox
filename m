Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276840AbRJDSds>; Thu, 4 Oct 2001 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277103AbRJDSd3>; Thu, 4 Oct 2001 14:33:29 -0400
Received: from Aniela.EU.ORG ([194.102.102.235]:1540 "EHLO NS1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S276840AbRJDSd0>;
	Thu, 4 Oct 2001 14:33:26 -0400
Date: Thu, 4 Oct 2001 21:33:52 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: Karl Pitrich <pit@root.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 100% sync block device on 2.2 ?
In-Reply-To: <Pine.LNX.4.33.0110042022560.1056-100000@warp.root.at>
Message-ID: <Pine.LNX.4.33.0110042132390.480-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > while :; do sync ; done
> >
> >
> > and everything should be in sync :)
>
> sync does not call fsync_dev(), nor it calls this flush ioctl i
> implemented in my driver.
> sync seems just to sync the vfs.

from my experience, sync flush all the buffers to disk just like the
kernel does when it receies a halt or reboot command.

>
>

