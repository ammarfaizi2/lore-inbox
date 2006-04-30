Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWD3E7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWD3E7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 00:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWD3E7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 00:59:24 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:9072 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750946AbWD3E7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 00:59:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WmsCBILnhoO5JQ65e2YLv/OsrCREh23ifFNr33MNmjrTbwo8YPvYp6mTwv6S7fw+oboUJ1oPCr3Bzq7rW/PUowZu6xfuSfrnUjV8Nromgb6F91wNG20zyERTV6ycYrCcvTWlSqnz+rPt6yOfxJP8PTBTFfwuPucQO1PFAb6phLo=
Message-ID: <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
Date: Sat, 29 Apr 2006 21:59:22 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: World writable tarballs
In-Reply-To: <200604300148.12462.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146356286.10953.7.camel@hammer>
	 <200604300148.12462.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Sunday 30 April 2006 01:18, Mark Rosenstand wrote:
> > Hi,
> >
> > It seems that at least the content of the 2.6.16 tarball is world
> > writable if extracted with GNU tar as an privileged user.
> >
> > Is this on purpose in order to prove some point?
>
> Read this thread:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113304241100330&w=2

This REALLY needs fixing. If it weren't so late right now I might have written
a filter that takes a tarball and sanitizes the permissions. I've got
good reasons
for compiling the kernel as root (when in the make, install, reboot, test loop
it's quite a timesaver).

Yes, I'm the guy who keeps trying to log in as root on ftp.kernel.org over ftp
with no password. For some bone-headed reason I keep thinking the default
username for ftp is anonymous, not the user's.
