Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVGZC4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVGZC4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVGZC4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:56:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25271 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261586AbVGZC4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:56:36 -0400
Subject: Re: mlock oops
From: Lee Revell <rlrevell@joe-job.com>
To: Benoit Dejean <bdejean@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aee4c5bc05072519431964a561@mail.gmail.com>
References: <aee4c5bc05072519431964a561@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 22:56:33 -0400
Message-Id: <1122346593.1472.84.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 04:43 +0200, Benoit Dejean wrote:
> Hi,
> 	i'm using Debian SID kernel-image-2.6.11-powerpc [1] (which is not
> tainted). I've unfortunately started sysutils [2] memtest as user (no caps, no
> sticky bit).
> 
> /usr/sbin/memtest all

> As expected, a few minutes later, my system was back. But an oops occured.

That's not an Oops...

> I was expecting the OOMK to rescue my system by killing memtest.
> 

This is exactly what happened:

> Out of Memory: Killed process 2386 (memtest).
> memtest: page allocation failure. order:0, mode:0xd2
> 

Lee

