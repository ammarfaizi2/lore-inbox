Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUKJKH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUKJKH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUKJKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:07:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261656AbUKJKHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:07:25 -0500
Date: Wed, 10 Nov 2004 10:07:23 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
Message-ID: <20041110100723.GE24336@parcelfarce.linux.theplanet.co.uk>
References: <20041110094011.0A3434BE64@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110094011.0A3434BE64@ws1-1.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 04:40:10AM -0500, Clayton Weaver wrote:
> Apropos of the recent "older compilers" discussion,
> the string literal concatenation pre-processor bug
> that I mentioned encountering in gcc-3.3.x and
> gcc-3.4.[0,1] appears to be fixed in gcc-3.4.3.
> (It was not the well-known "##" token pasting
> pre-processor bug, incidentally.)
> 
> I've only tested with glibc-2.2.5 so far,
> but I could reproduce it before with both
> glibc-2.2.5 and glibc-2.3.2, so it probably
> really is fixed.

1) What the hell does glibc version have to preprocessor behaviour?
2) Could you post the code (as small as possible) that triggers whatever
bug you are talking about?  Not a "here's the fragment that gets miscompiled"
but something that could be fed to gcc and actually reproduce the bug.
