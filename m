Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTIDEmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTIDEmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:42:45 -0400
Received: from rth.ninka.net ([216.101.162.244]:32200 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264553AbTIDEmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:42:44 -0400
Date: Wed, 3 Sep 2003 21:42:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: phillips@arcor.de, elenstev@mesatop.com, wind@cocodriloo.com,
       lm@bitmover.com, cat@zip.com.au, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-Id: <20030903214233.24d3c902.davem@redhat.com>
In-Reply-To: <20030904015249.GF5227@work.bitmover.com>
References: <20030903040327.GA10257@work.bitmover.com>
	<20030903124716.GE2359@wind.cocodriloo.com>
	<1062603063.1723.91.camel@spc9.esa.lanl.gov>
	<200309040350.31949.phillips@arcor.de>
	<20030904015249.GF5227@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 18:52:49 -0700
Larry McVoy <lm@bitmover.com> wrote:

> On Thu, Sep 04, 2003 at 03:50:31AM +0200, Daniel Phillips wrote:
> > There are other arguments, such as how complex locking is, and how it will 
> > never work correctly, but those are noise: it's pretty much done now, the 
> > complexity is still manageable, and Linux has never been more stable.
> 
> yeah, right.  I'm not sure what you are smoking but I'll avoid your dealer.

I hate to enter these threads but...

The amount of locking bugs found in the core networking, ipv4, and
ipv6 for a year or two in 2.4.x has been nearly nil.

If you're going to try and argue against supporting huge SMP
to me, don't make locking complexity one of the arguments. :-)
