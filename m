Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVFUSMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVFUSMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVFUSMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:12:01 -0400
Received: from [81.2.110.250] ([81.2.110.250]:45732 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262114AbVFUSMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:12:00 -0400
Subject: Re: -mm -> 2.6.13 merge status (HZ -> 250?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119371192.19357.40.camel@mindpipe>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119371192.19357.40.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119377341.3304.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 19:09:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 17:26, Lee Revell wrote:
> Consider a program with a 5ms RT constraint, like a game or mplayer.
> Currently it uses the RTC on 2.4/HZ=100 systems and usleep() on
> 2.6/HZ=1000.  Allowing HZ to regress to 250 would force us to handle
> 2.4, 2.6.1 - 2.6.12, and 2.6.13+ separately.  It would be a huge mess.

Vendors already ship 100Hz and 1KHz kernels. 2.4 and 2.6 are different
already. I can see the argument for not picking another new value
though.
