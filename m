Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUBVCRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUBVCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:17:12 -0500
Received: from holomorphy.com ([199.26.172.102]:5893 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261618AbUBVCRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:17:11 -0500
Date: Sat, 21 Feb 2004 18:17:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222021710.GD703@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40380DE2.4030702@matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Similar issue here; I ran out of filp's/whatever shortly after booting.

On Sat, Feb 21, 2004 at 06:03:14PM -0800, Mike Fedyk wrote:
> So Nick Piggin's VM patches won't help with this?

I think they're in -mm, and I'd call the vfs slab cache shrinking stuff
a vfs issue anyway because there's no actual VM content to it, apart
from the code in question being driven by the VM.


-- wli
