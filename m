Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWDCX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWDCX0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWDCX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:26:30 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:49315 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964818AbWDCX03 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:26:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnaw8QT+ClrsEKCi3AibzCLScyEwEygmkgOAKCqDyhcdJ+D0s6a4c+qwVQaPJrowQPX9VAyn1RYvbpCmBC+aU+dwtbMVzWepPbd5u/2xI/sxqpLZPIqq5s301kfgJ0zGUO51xC9ulfKVXfZI0DoMiTdDk6bVgR4MepIHwdakcpM=
Message-ID: <bda6d13a0604031626w67c759f3r90af446f3d73aa88@mail.gmail.com>
Date: Mon, 3 Apr 2006 16:26:28 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <4431A93A.2010702@plan99.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4431A93A.2010702@plan99.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/06, Mike Hearn <mike@plan99.net> wrote:
> Alright, Andrew Morton indicated that he liked this patch but the idea
> needed discussion and mindshare. I asked Con Kolivas if it made sense to
> go in his desktop patchset for people to try: he said he liked it too
> but it's not his area, and that it should be discussed here.
>
> To clarify, I'm proposing this patch for eventual mainline inclusion.
>
> It adds a simple bit of API - a symlink in /proc/pid - which makes it
> easy to build relocatable software:
>
>    ./configure --prefix=/proc/self/exedir/..
>
> This is useful for a variety of purposes:
>
> * Distributing programs that are runnable from CD or USB key (useful for
>    Linux magazine cover disks)
>
> * Binary packages that can be installed anywhere, for instance, to your
>    home directory
>
> * Network admins can more easily place programs on network mounts
>
> I'm sure you can think of others. You can patch software to be
> relocatable today, but it's awkward and error prone. A simple patch can
> allow us to get it "for free" on any UNIX software that uses the
> idiomatic autotools build system.
>
> So .... does anybody have any objections to this? Would you like to see
> it go in? Speak now or forever hold your peace! :)
>
> thanks -mike
Love it. I hope it doesn't get shot down.
