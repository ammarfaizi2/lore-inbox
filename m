Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUC2W44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUC2Wzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:55:55 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:20902
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S263170AbUC2Wzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:55:47 -0500
In-Reply-To: <Pine.LNX.4.53.0403291659400.3272@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos> <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291644200.3114@chaos> <BB3FCEF5-81CB-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291659400.3272@chaos>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <35350CCA-81D4-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 14:55:43 -0800
To: root@chaos.analogic.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2004, at 2:10 PM, Richard B. Johnson wrote:
> You didn't care to read what I said? I said to remove those sym-links.
> They must be replaced by headers that were in-use around the time
> the C library code was compiled, preferably the exact same headers.
>
> There must not be any sym-link in the /usr/include/... directories
> pointing to any kernel headers. That way, you can add new kernels
> without ever screwing up your compiler.

Understood.  Incidentally, the glibc-kernheaders package included with 
RH 7.3 creates those files as symlinks, I'm sure however that they were 
there for the compilation of glibc.  The disconnect that I forsee, is 
that I will be running the 2.2.26 with kernel headers from a 2.4.x 
kernel - would this be the correct thing to do?

I suppose I mirror the sentiments of DervishD on this from his post.

-lev

