Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVK3VmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVK3VmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVK3VmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:42:17 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:19096 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750922AbVK3VmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:42:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GHEg2xqAw5wIwwERaD11LH+NTBlWrVTyAtSvw7Ccrs/GEtV1J3gUxONic8D9qTnw4Q9L6qnCpnUUnSAals9Pq1X5GH8Fs40w920i/+yDmdJTUZMOJ8Hbv4zw6ZcC60Ag/kx63LWST3wCe9ZtiZbbHmj1Qv9PDnIJegni+ofgLMc=
Message-ID: <a762e240511301342x6e754cafsed9db386d05a6b2b@mail.gmail.com>
Date: Wed, 30 Nov 2005 13:42:16 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051130200448.76281.qmail@web34103.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1132620540.8011.58.camel@lade.trondhjem.org>
	 <20051130200448.76281.qmail@web34103.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are still reporing free pages.  Do you seen the OOM killer killing
processes?

How big is the file you are doing your test on?  How big is your
filesize var when the box hangs?

If you run this test without nfs (on a local file system) do you end
up in this low memory state as well or only over a nfs mount?

thanks,
 Keith
