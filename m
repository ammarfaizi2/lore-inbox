Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUJRCRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUJRCRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 22:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUJRCRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 22:17:00 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:55992 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269356AbUJRCQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 22:16:58 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=udp/vzBLHhtPVskmcAyAgfB5y+hMbKiCN5mE0bjyCM94KMDUKj26ZViBujk1QbCHKePospqwKD/utVFRcQz8+NJlEH6eQL5HdvcFMaSvAz/z0uV65T2H9GSPLk+pVnPmk9UWmSUhYvPUl7XXuTq2fjHRsq/Zy7AA7gSPkrQlMmY
Message-ID: <35fb2e59041017191624c9b44b@mail.gmail.com>
Date: Mon, 18 Oct 2004 03:16:58 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Running user processes in kernel mode; Java and .NET support in kernel
Cc: Simon Kissane <skissane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200410172253.28215.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <82fa66380410152111143f75ec@mail.gmail.com>
	 <82fa6638041016055934097b80@mail.gmail.com>
	 <200410172253.28215.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 22:53:28 +0300, Denis Vlasenko
<vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> On Saturday 16 October 2004 15:59, Simon Kissane wrote:

> > Also, I found a website by someone who had this idea before me (and
> > unlike me, actually implemented it!).
> > "Kernel Mode Linux" by Toshiyuki Maeda
> > http://web.yl.is.s.u-tokyo.ac.jp/~tosh/kml/

> Nice page. Doubly nice considering that they have working code.

We looked at it briefly as part of a discussion in the office about
user mode device drivers, not really that seriously - one of those
lunchtime things. In the end it's far better to just mmap /dev/mem and
be done with it anyway. Other than that I can see little use for this.
Machines without an MMU running uclinux effectively run like this
anyway.

Jon.
