Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVEBRb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVEBRb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVEBQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:27:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11564
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261383AbVEBQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:11:33 -0400
Date: Mon, 2 May 2005 18:17:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050502161722.GN20146@opteron.random>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42764C0C.8030604@tmr.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 11:49:32AM -0400, Bill Davidsen wrote:
> Could you explain why this is necessary or desirable? I looked at what 

This is necessary here because of this:

andrea@opteron:~> which python
/home/andrea/bin/x86_64/python/bin/python

Of course I've /home/andrea/bin/x86_64/python/bin in the path before
/usr/bin.

The generally accepted way to start it is through env, other scripts in
mercurial were already getting that right too so it was probably not
intentional to hardcode it in the hg binary.
