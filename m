Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUBDPUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUBDPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:20:54 -0500
Received: from peabody.ximian.com ([130.57.169.10]:2973 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263101AbUBDPUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:20:52 -0500
Subject: Re: [patch] 2.4's sys_readahead is borked
From: Robert Love <rml@ximian.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
References: <1075853962.8022.3.camel@localhost>
	 <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
Content-Type: text/plain
Message-Id: <1075908048.11309.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Wed, 04 Feb 2004 10:20:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 12:30 -0200, Marcelo Tosatti wrote:

Hi, Marcelo.

> Hi Robert,
> 
> This looks okay, applied.

Thanks!

> Question: Do you know any user of sys_readahead() ?

Not really - I've been playing with it.  But OpenOffice just added it to
preload some of their libraries.  It should probably be deprecated and
remove in 2.7, since posix_fadvise(POSIX_FADV_WILLNEED) does this same
thing.

	Robert Love


