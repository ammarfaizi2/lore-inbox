Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274833AbRJKCOb>; Wed, 10 Oct 2001 22:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277511AbRJKCOW>; Wed, 10 Oct 2001 22:14:22 -0400
Received: from femail38.sdc1.sfba.home.com ([24.254.60.32]:59640 "EHLO
	femail38.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275841AbRJKCON>; Wed, 10 Oct 2001 22:14:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Balbir Singh <balbir.singh@wipro.com>
Subject: Re: is reparent_to_init a good thing to do?
Date: Wed, 10 Oct 2001 18:13:45 -0400
X-Mailer: KMail [version 1.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC3118B.8050001@wipro.com> <3BC42E65.3060706@wipro.com> <3BC446E0.5020604@wipro.com>
In-Reply-To: <3BC446E0.5020604@wipro.com>
MIME-Version: 1.0
Message-Id: <01101018134508.11498@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 October 2001 09:02, BALBIR SINGH wrote:
> Balbir Singh wrote:
> > Rob Landley wrote:
> >> Or long lived kernel threads from short lived login sessions.
...
> Ooh! sorry this is a wrong approach to send SIGCHLD to the previous parent.
> AFAIK, all shells send their children SIGHUP when the shell exits, but SSH
> may have some special security consideration in waiting for all children to
> exit, does anyone know?
>
> Balbir

The problem I mentioned above was the reason "reparent_to_init" was created 
in the first place.  Here it is in the archive:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.0/0045.html

I.E. already fixed...

Google could probably find Jimmy Hoffa given half a chance...  (If we could 
just figure out how to connect it up to maps.yahoo.com...)

Rob
