Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWAPUZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWAPUZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWAPUZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:25:32 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:27708 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751191AbWAPUZb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:25:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WSjm0SdwPgTdDty7avaPD7YMoYr5yuZea387CoCeY9wXRaWLy3PSLZs1PVfKLiKyC+2WfUtc3JC6wHQu60GmxZ3X+FMKcdqPbY266RdI4oUTftH2ZqeHLys/whwPq7wU4Jz2D+BQXuuhsVoj3OcH55hZRpFB82YhJiK3bUuXuf4=
Message-ID: <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
Date: Mon, 16 Jan 2006 15:25:30 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <1137442446.19444.20.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
	 <1137442446.19444.20.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What userspace app will break because of this?

On 1/16/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-01-16 at 15:04 -0500, Andy Gospodarek wrote:
> > Printing the total number of sockets used in /proc/net/sockstat is out
> > of place in a file that is supposed to contain information related to
> > ipv4 sockets.  Removed output for total socket usage.
> >
>
> Um, you can't do that, it will break userspace.
>
> Lee
>
>
