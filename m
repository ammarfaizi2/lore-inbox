Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286502AbRLUAi0>; Thu, 20 Dec 2001 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286503AbRLUAiP>; Thu, 20 Dec 2001 19:38:15 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:29354 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286502AbRLUAiL>; Thu, 20 Dec 2001 19:38:11 -0500
Date: Fri, 21 Dec 2001 00:39:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        andrea@suse.de, davej@codemonkey.org.uk, Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
Message-ID: <20011221003942.B26268@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>, andrea@suse.de,
	Chuck Lever <cel@monkey.org>
In-Reply-To: <20011221000806.A26849@suse.de> <shssna58lpq.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shssna58lpq.fsf@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:

 >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
 > Lever's NFS patches you've been testing?

Nope, stock 2.4.17rc2 & 2.5.1. 
I thought NFS might just ignore the O_DIRECT flag if it didn't
understand it yet, I wasn't expecting such a dramatic failure.

I just got reminded of the bugs Andrew Morton & some others
found in O_DIRECT, so this may be hitting the same problems
already found.

Dave.

