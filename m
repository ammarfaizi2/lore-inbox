Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWDRGaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWDRGaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDRGaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:30:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:3741 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932242AbWDRGaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:30:05 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.16.1 & D state processes
From: Mike Galbraith <efault@gmx.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060418050721.89784.qmail@web52614.mail.yahoo.com>
References: <20060418050721.89784.qmail@web52614.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 08:30:22 +0200
Message-Id: <1145341823.9243.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 15:07 +1000, Srihari Vijayaraghavan wrote:
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
...
> And oh, eventually machine recovers (minutes
> sometimes, hours other times), & it runs as if nothing
> happend, as long as you're not quick to power button.
> Sure, you can't login, or you can't execute commands,
> if you managed to login etc. But patience does bring
> the machine back every time :-).

Hmm.  Recovers [odd] but takes long time [odder].  I'd try to eliminate
io scheduler at this point.

	-Mike

