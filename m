Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVJOCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVJOCa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 22:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVJOCa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 22:30:29 -0400
Received: from xenotime.net ([66.160.160.81]:14797 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751036AbVJOCa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 22:30:29 -0400
Date: Fri, 14 Oct 2005 19:30:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bob.picco@hp.com,
       clemens@ladisch.de
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
Message-Id: <20051014193025.653886f0.rdunlap@xenotime.net>
In-Reply-To: <20051004124126.23057.75614.schnuffi@turing>
References: <20051004124126.23057.75614.schnuffi@turing>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2005 14:41:26 +0200 (MEST) Clemens Ladisch wrote:

> Another round of HPET bugfixes and cleanups.
> 
>  drivers/char/hpet.c |   35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Hi,

I've applied and tested all of these along with what is
currently in -mm (only -mm hpet + timer patches).

By "tested" I mean that I booted the kernel.  :)

What kind of testing have you done?
Do you have any timer test tools that you use to verify that
timers are actually working as expected?

Or maybe I could/should ask one or all of:
- John Stultz
- Thomas Gleixner
- George Anzinger (HRT project does have some tests)

Thanks,
---
~Randy
