Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbULQPlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbULQPlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULQPlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:41:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261316AbULQPjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:39:13 -0500
Date: Fri, 17 Dec 2004 10:38:46 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Pavel Machek <pavel@ucw.cz>
cc: Bryan Fulton <bryan@coverity.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, <netfilter-devel@lists.netfilter.org>
Subject: Re: [Coverity] Untrusted user data in kernel
In-Reply-To: <20041217151031.GA27170@atrey.karlin.mff.cuni.cz>
Message-ID: <Xine.LNX.4.44.0412171038140.14229-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, Pavel Machek wrote:

> Hi!
> 
> > This at least needs CAP_NET_ADMIN.
> 
> Hmm, but that means that CAP_NET_ADMIN implies all other capabilities,
> unless you fix this.

I'm not saying it doesn't need to be fixed, but that it is not exploitable 
by unprivileged users.


- James
-- 
James Morris
<jmorris@redhat.com>


