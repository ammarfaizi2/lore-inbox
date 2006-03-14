Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWCNPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWCNPkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWCNPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:40:13 -0500
Received: from ns1.suse.de ([195.135.220.2]:42708 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751836AbWCNPkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:40:11 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
Date: Tue, 14 Mar 2006 16:39:38 +0100
User-Agent: KMail/1.8
Cc: Andrew Clayton <andrew@rootshell.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <1142337319.4412.2.camel@zeus.pccl.info> <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141639.38988.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 16:30, Hugh Dickins wrote:
> Andi, if you've a replacement patch you'd like everybody to test,
> please post: I for one will surely give it a try.

Hrm, it worked on my test machine. 

But what happens when you just revert the last hunk (the stub_execve change)?

-Andi
