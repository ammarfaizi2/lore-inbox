Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWELENk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWELENk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 00:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWELENj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 00:13:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:21480 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750892AbWELENj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 00:13:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1z9QOZlvqNCigXZDm/44HlnfaUF69UzHewl+yOpmlF3Tw3UEGQ+YgKwTR56S1GnGW5OKf7X/zz8mX7II3cLYGrXqzuTUhY5fNFT1kM89zdm3sefybjPVTCrY1SYr2j50bcrdML1YuDXV1BKtihmalcQ1n2z6u7MC5cQ/7lP6tM=
Message-ID: <21d7e9970605112113s16764073tca5246d1e104503b@mail.gmail.com>
Date: Fri, 12 May 2006 14:13:38 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: SecurityFocus Article
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Ed White" <ed.white@libero.it>, ML <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910605112017u428c04cdm2ff40b53785db09c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060511143440.23517.qmail@securityfocus.com>
	 <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
	 <9e4733910605112017u428c04cdm2ff40b53785db09c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The X server doesn't need to go into the kernel, only a very tiny
> portion of it needs to go in. But X blindly pursues the idea of total
> platform independence which means it ignores many of the services
> offer by the Linux kernel and reimplements them in user space. This is
> because the BSDs are missing many things that Linux supports.
>
> I just love the idea of 2.4M lines of X code that opens network
> sockets needlessly running as root. Top it off with 1,300 unfixed
> Coverity hits, http://scan.coverity.com/. But what fun is life if you
> don't live a little dangerously. If you want ideas on how to fix X to
> not run as root read,
> http://people.freedesktop.org/~jonsmirl/graphics.html
>
> Of course DaveA will chime in and say that they are working on fixing
> things to use the Linux kernel. This is good and I am glad it is being
> done, I just worry that it will get finished sometime around 2014.

I'll also suggest you stop talking out of your arse, there are no
aliens in Area 51 either Jon and man did walk on the moon, refuting
the crap you post takes more time than fixing X...

Coverity scan is all of X (clients, libraries, server, apps) not just
the X server, it is also against the old 6.9 tree not the modular
tree, so it never gets anything fixed as that tree is dead. We are
working with coverity to scan modular instead.

My current X server hasn't any network sockets open by default.

Your ideas to fix X didn't result in patches to fix X, ideas are great
we all have ideas, patches are better, for some reason we don't all
have patches.

We are fixing X, you are not.

Dave.
