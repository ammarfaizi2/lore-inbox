Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUHSPMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUHSPMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHSPJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:09:54 -0400
Received: from holomorphy.com ([207.189.100.168]:62144 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266450AbUHSPGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:06:42 -0400
Date: Thu, 19 Aug 2004 08:06:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: includes cleanup.
Message-ID: <20040819150632.GP11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819143907.GA4236@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 03:39:07PM +0100, Dave Jones wrote:
> I noticed that every file that could be built as a module was sucking
> in sched.h (and therefore, every other include file under the sun).
> This patch
[... which bits got moved to more appropriate places...]
> I've not done any measurements to see if this is noticable on a compile,
> as I'd expect it to be mostly in the noise anyway (though last time I
> did this in 2.5.early, it did shave off the best part of a minute off
> my worst-case-scenario build), but untangling the spaghetti of includes
> a little should at least mean gcc uses less memory during the build.
> comments?

sched.h is such an extreme garbage can header I wouldn't mind seeing the
whole thing torn completely apart. Every little trimming is good. =)


-- wli
