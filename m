Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280563AbRKSScH>; Mon, 19 Nov 2001 13:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKSSbr>; Mon, 19 Nov 2001 13:31:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61542 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280538AbRKSSbj>; Mon, 19 Nov 2001 13:31:39 -0500
To: Erik Gustavsson <cyrano@algonet.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net>
	<E165ZRi-000718-00@mauve.csi.cam.ac.uk>
	<3BF827E1.5A2C7427@starband.net> <3BF82B3C.8070303@wanadoo.fr>
	<1006124602.3890.0.camel@bettan>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 11:12:27 -0700
In-Reply-To: <1006124602.3890.0.camel@bettan>
Message-ID: <m1snba7hpw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Gustavsson <cyrano@algonet.se> writes:

> I agree...   After a while it always seems that 80% or more of my RAM is
> used for cache and buffers while my open, but not currently used apps
> get pushed onto disk. Then when I decide to switch to that mozilla
> window of emacs session I have to wait for it to be loaded from disk
> again. Also considering the kind of disk activity this box has, the data
> in the cache is mostly the last few hour's MP3's, in other words utterly
> useless as that data will not be used again. I'd rather my apps stayed
> in RAM...

> 
> Is there a way to limit the size of the cache?

Reasonable.  It looks like the use once heuristics are failing for your
mp3 files.   Find out why that is happening and they should push the
rest of your system into swap.

Eric
