Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUH1Gsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUH1Gsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUH1Gsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:48:36 -0400
Received: from holomorphy.com ([207.189.100.168]:48804 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268206AbUH1Gse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:48:34 -0400
Date: Fri, 27 Aug 2004 23:48:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040828064829.GB5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org> <20040828063419.GA5492@holomorphy.com> <20040827234033.2b6e1525.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827234033.2b6e1525.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> You mean a big-endian one? I did check to be sure none did so; only
>> x86-64 does. Easy enough to dress up so BE arches can do it too.

On Fri, Aug 27, 2004 at 11:40:33PM -0700, Andrew Morton wrote:
> hm.  Actually, the page_flags_t hack can only work on little-endian
> hardware anyway.
> perhaps your implementation should imitate x86_64/bitops.h and use a void*,
> along with apologetic comments.

Okay, I'll resend it done that way.


-- wli
