Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVAQQtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVAQQtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVAQQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:49:23 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:43949 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262321AbVAQQtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:49:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: hugang@soulinfo.com
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Mon, 17 Jan 2005 17:49:36 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501161107.24883.rjw@sisk.pl> <20050116144641.GA14825@hugang.soulinfo.com>
In-Reply-To: <20050116144641.GA14825@hugang.soulinfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501171749.37070.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 16 of January 2005 15:46, hugang@soulinfo.com wrote:
> On Sun, Jan 16, 2005 at 11:07:24AM +0100, Rafael J. Wysocki wrote:
> > > 
> > > I disable Flush TLB after copy page, It speedup the in qemu, But I can't
> > > sure the right thing in real machine, can someone give me point.
> > 
> > Could you, please, make a patch against -rc1-mm1 with your previous patch
> > applied?  It would be much easier to apply. :-)
> > 
> 
> http://soulinfo.com/~hugang/swsusp/2005-1-16/

I have tested this (a couple of suspend-resume cycles) and it works.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
