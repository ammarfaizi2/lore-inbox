Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVEEDF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEEDF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 23:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEEDF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 23:05:57 -0400
Received: from stephanie.vergenet.net ([203.222.130.46]:14505 "EHLO
	stephanie.vergenet.net") by vger.kernel.org with ESMTP
	id S261862AbVEEC6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:58:44 -0400
Date: Thu, 5 May 2005 12:34:49 +1000
From: Horms <horms@verge.net.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org, 277298@bugs.debian.org
Subject: Re: RTC problem on 8208CA
Message-ID: <20050505023447.GB3988@verge.net.au>
References: <20050502051634.GA18295@verge.net.au> <20050504032541.58650.qmail@web60513.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504032541.58650.qmail@web60513.mail.yahoo.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 08:25:41PM -0700, Paul Gortmaker wrote:
> At a glance this sounds like the case of having the HPET enabled causes
> the RTC IRQ functionality to become crippled or non-functional.  The
> concept of hwclock using alarm or similar to handle broken and
> misconfigured hardware is a sensible idea.

Thanks for the advice. I guess I was holding onto an idea
that it could be fixed in the kernel - but you are right,
the user-space work around is a simple solution to this
buggy hardware.

-- 
Horms
