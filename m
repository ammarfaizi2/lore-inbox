Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286340AbRLTToJ>; Thu, 20 Dec 2001 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286355AbRLTTnu>; Thu, 20 Dec 2001 14:43:50 -0500
Received: from [207.88.206.43] ([207.88.206.43]:7822 "HELO
	intruder-luxul.gurulabs.com") by vger.kernel.org with SMTP
	id <S286350AbRLTTnk>; Thu, 20 Dec 2001 14:43:40 -0500
Date: Thu, 20 Dec 2001 12:43:38 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: <dkelson@mooru.gurulabs.com>
To: David Chow <davidchow@rcn.com.hk>
cc: "trond.myklebust@fys.uio.no" <trond.myklebust@fys.uio.no>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: nfsroot dead slow with redhat 7.2
In-Reply-To: <1008836323.972.6.camel@star7.planet.rcn.com.hk>
Message-ID: <Pine.LNX.4.33.0112201241450.6262-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2001, David Chow wrote:

> Just find out... it is a problem of some settings in /etc directory 
> it is not related to the FSes . I replaced the /etc directory with the
> one we are using on the production machines... by the way. What can be
> wrong? When it starts init , and execute the /etc/rc.d/rc.sysinit , it
> is hell slow. We have tried replace /sbin/init with bash and we got out
> a shell but "ls -l" takes more than 2 minutes... do you know what sort
> of settings in the /etc will affect use space "bash" or "glibc" on
> nfsroot behaves different ? This is so strange.

David.  I asked yesterday for you to try "ls -ln" and report if it is any
faster.  What you are just now discovering, I suspected when I first read 
your report.

Please try "ls -ln" and report.

Dax

