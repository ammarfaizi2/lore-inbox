Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313792AbSDPToL>; Tue, 16 Apr 2002 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313811AbSDPToL>; Tue, 16 Apr 2002 15:44:11 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:33944 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S313792AbSDPToJ>;
	Tue, 16 Apr 2002 15:44:09 -0400
Subject: Re: Linux 2.4.19-pre7
From: Bongani <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020416123549.A16359@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 21:58:04 +0200
Message-Id: <1018987145.2505.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 12:35, Gerd Knorr wrote:
> > > 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
> > > Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled
> > > for 5 minutes
> > 
> > Hi, I found that my ttyS0 had turned into ttyS1 :-) My modem was
> > unresponsive, until I changed the setting to use ttyS1, hope this helps.
> 
> Making getty using ttyS1 works for me too, I have my login prompt back.
> Looks like a off-by-one bug ...
> 
>   Gerd
> 
And I thought devfs was the one responsible for changing ttyS0 to
ttyS1. But I this is happening on 2.4.19-pre6. If I remember correctly
this started happening when I decided to use devfs. I will disable devfs
and see if it happens again. Is anyone else with the sane problem also
using devfs?


