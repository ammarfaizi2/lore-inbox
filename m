Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUI2IY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUI2IY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUI2IY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:24:58 -0400
Received: from holomorphy.com ([207.189.100.168]:20371 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268263AbUI2IYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:24:51 -0400
Date: Wed, 29 Sep 2004 01:24:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move struct k_itimer out of linux/sched.h
Message-ID: <20040929082437.GH9106@holomorphy.com>
References: <200409290134.i8T1YOI9002933@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409290134.i8T1YOI9002933@magilla.sf.frob.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 06:34:24PM -0700, Roland McGrath wrote:
> I don't know why struct k_itimer was ever declared in sched.h; perhaps at
> one time it was referenced by something else there.  There is no need for
> it now.  This patch moves the struct where it belongs, in linux/posix-timers.h.
> It has zero effect on anything except keeping the source easier to read.

This reminds me of Message-ID: <20040925031912.GP9106@holomorphy.com>


-- wli
