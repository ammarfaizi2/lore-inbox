Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVDREzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVDREzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDREzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:55:44 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34465 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261669AbVDREzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:55:39 -0400
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
From: Nicholas Miell <nmiell@comcast.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050418044223.GB15002@nevyn.them.org>
References: <4263275A.2020405@lab.ntt.co.jp>
	 <20050418040718.GA31163@taniwha.stupidest.org>
	 <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>
Content-Type: text/plain
Date: Sun, 17 Apr 2005 21:55:36 -0700
Message-Id: <1113800136.355.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 00:42 -0400, Daniel Jacobowitz wrote:
> On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
> > GDB based approach seems not fit to our requirements. GDB(ptrace) based 
> > functions are basically need to be done when target process is stopping.
> > In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
> > *word* size...
> 
> While true, this is easily fixable.  There is even an interface
> precedent on OpenBSD (and possibly other platforms as well).
> 

If we're going to be stealing ideas for debugging interfaces from other
operating systems, could we steal from Solaris instead of anything
ptrace-based?

-- 
Nicholas Miell <nmiell@comcast.net>

