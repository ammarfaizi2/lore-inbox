Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267996AbUBRUV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUBRUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:21:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:45282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267996AbUBRUVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:21:06 -0500
Date: Wed, 18 Feb 2004 12:22:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brandon Low <blow@rbsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040218122216.62bb9e82.akpm@osdl.org>
In-Reply-To: <20040218200439.GB449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org>
	<40338FE8.60809@tmr.com>
	<20040218200439.GB449@lostlogicx.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <blow@rbsys.com> wrote:
>
> I must add my voice here in strong opposition of the removal of
>  cryptoloop from the 2.6 series of kernels.  This is no longer a
>  development series kernel, I (and others, I'm sure) have been working on
>  developing technologies which depend on this functionality and which
>  would be _very_ annoying to do with DM (liveCD-on-cryptoloop-on-iso).

Why is it problematic?

>  Please do not drop cryptoloop!

ho-hum.  Why should we retain crypto capabilities which have widely
understood vulnerabilities?

We mainly want to remove the bio remapping stuff from the loop driver
because it's horrid and deadlocks under heavy memory pressure.  Maybe we
can leave crytoloop there with big "kindergarten crypto - do not use"
labels all over it.


