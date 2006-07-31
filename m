Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWGaPqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWGaPqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWGaPqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:46:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19907 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030201AbWGaPqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:46:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sj89Lk7HccRw0LmWuqYXSlC7qCBvWZ2E0GBT9I3/QwPoUH9xbbAOaBhxJ16X/7dIio6rq2TLCaNlmHR3y41Dnt/X8WMr3EQN5aS0+y9pLVc6QzxUwG7vBe1cENBLen0m9imi2+LRQ3vfwkncew/LPtRUcEO8asK7KSMMsyI4pHs=
Message-ID: <7c3341450607310846p33049e72o17c1acd446110c4d@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:46:08 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: Valdis.Kletnieks@vt.edu
Subject: Re: Preserving uptime with kexec?
Cc: "Thomas Tuttle" <thinkinginbinary@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200607311412.k6VECX1G004087@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731125913.GA27083@phoenix>
	 <200607311412.k6VECX1G004087@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of which, I have submitted a claim to Guiness Book of Records
for my uptime on a lowly 486 box that serves my webpages (via NFS) as
a 'home user' (I am sure business classed machines do better with UPS
etc.).  I have posted here twice when it hit 1000 days and then 1500
days:

[nick@486Linux nick]$ uname -a
Linux 486Linux 2.2.13-7mdk #1 Wed Sep 15 18:02:18 CEST 1999 i486 unknown

[nick@486Linux nick]$ last -xf /var/run/utmp runlevel
runlevel (to lvl 3)                    Sun Oct 14 16:07 - 16:42 (1751+00:34)

The claim has been accepted, and is now in evaluation... so I dunno
what happens next until I hear from them (or how it can be verified
unless someone pops along and I telnet into the box for them).

Nick



On 31/07/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 31 Jul 2006 08:59:13 EDT, Thomas Tuttle said:
> > Like many people, I like to brag about how great my uptime is.  But like
> > many other people, I like to keep my kernel up-to-date with the latest
> > and greatest from kernel.org.  I recently discovered the magic of kexec,
> > which allows me to switch kernels without rebooting for real.
> > Unfortunately, kexec resets my uptime when it runs.
>
> The reset of uptime is probably a Good Thing.  Consider the case of
> a kernel memory leak - you look in /proc/meminfo and find that you've
> managed
> to lose 64 meg of memory to the leak.  Where you start looking for the
> leak will depend on whether it's 64 meg lost across 4 weeks since the
> last boot, or the 30 minutes since the last boot.
>
> (Speaking as somebody who's run into both classes of leaks...)
>
>
>
>
