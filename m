Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbUJ0G4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUJ0G4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUJ0Gy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:54:29 -0400
Received: from [213.188.213.77] ([213.188.213.77]:55446 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S262299AbUJ0Guu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:50:50 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Willy Tarreau'" <willy@w.ods.org>
Cc: "'Rik van Riel'" <riel@redhat.com>,
       "'Marcos D. Marado Torres'" <marado@student.dei.uc.pt>,
       "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: My thoughts on the "new development model"
Date: Wed, 27 Oct 2004 08:50:35 +0200
Message-ID: <015b01c4bbf1$48069580$e60a0a0a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20041027062833.GV15367@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 27, 2004 at 08:04:33AM +0200, Willy Tarreau wrote:
> > Oh yes I remember... I was very interested because of netfilter and 
> > ramfs but couldn't use it because of its awful stability. That was 
> > when I started complaining about linux development model, where new 
> > features were more important than bug fixes, which resulted in no 
> > usable kernel before 2.4.18.
> 
> 2.6.x has taken a rather different path from 2.4.x

However, results are similar. 

2.6 seems to work better than 2.4 in "early stage of stable branch" but
It's quite impossible to set up a production server on 2.6.x, optimize
it and keeping the same performance with 2.6.(x+2).

Iosched has a lot of flavours, with performance worse than 2.4 (at least
for databases). 
Swap is a misterious thing and It needs a degree in swappiness to
understand how it works and how it changes.

I see a lot of efforts in making a top-performance kernel but these
efforts are not compatible with a stable-tree.

Stable means not only that the kernel does not hangs, but that features
remains (almost) the same for a reasonable amount of time.

Max

