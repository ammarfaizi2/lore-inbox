Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWIGUJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWIGUJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWIGUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:09:20 -0400
Received: from 1wt.eu ([62.212.114.60]:19474 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751979AbWIGUJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:09:19 -0400
Date: Thu, 7 Sep 2006 22:07:14 +0200
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060907200713.GB541@1wt.eu>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <44FFF1A0.2060907@openvz.org> <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 08:17:04AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 7 Sep 2006, Kirill Korotaev wrote:
> > 
> > Does the patch below looks better?
> 
> Yes. 
> 
> Apart from the whitespace corruption, that is.
> 
> I don't know how to get mozilla to not screw up whitespace.

maybe by using it to download mutt or something saner ? :-)

More seriously, while we don't like email attachments because they make
it impossible to comment on a patch, maybe we should encourage people
with broken mailers to post small patches in both forms :
  - pure text for human review (spaces are not much of a problem here)
  - MIME to apply the patch.

At least when the do so, they should insist on it at the top of the
patch, or even manually mangle the patch header so that GIT (or any
other tool) does not use it.

> 		Linus

Regards
Willy

