Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWCACZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWCACZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWCACZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:25:45 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:27273 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964822AbWCACZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:25:44 -0500
Date: Tue, 28 Feb 2006 21:22:31 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-ID: <200602282125_MC3-1-B98B-5908@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060228161512.0cdbe560.akpm@osdl.org>

On Tue, 28 Feb 2006 16:15:12, andrew Morton wrote:

> >
> >  This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).
> 
> Wonderful, thanks.  What's the relationship (if any) between this and the
> recently-merged x86_64 fix?

This is the same fix ported to i386 for people with Sempron processors
or running i386 kernels on x86_64 systems.

The problems with the earlier disable_timer_pin_1 fix don't seem to happen with
this one; I even booted an old i386 SMP machine with the new boot option
'disable_8254_timer' and it worked fine.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

