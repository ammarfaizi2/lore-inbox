Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWHSAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWHSAaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWHSAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:30:39 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:29407 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1751293AbWHSAaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:30:39 -0400
Date: Sat, 19 Aug 2006 02:30:37 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mattia Dongili <malattia@linux.it>, Miles Lane <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl system call
Message-ID: <20060819003037.GB6440@boogie.lpds.sztaki.hu>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com> <1155854702.8796.97.camel@mindpipe> <20060818144626.GA8236@inferi.kami.home> <1155918234.24907.35.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155918234.24907.35.camel@mindpipe>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 12:23:54PM -0400, Lee Revell wrote:

> "fixed"?  Why is sysctl being removed in the middle of a stable kernel
> series?!?

IMHO the stable series is 2.6.x.y nowadays. 2.6.z (without a fourth
number) is more or less what used to be 2.<odd> previously.

> I thought the new golden rule was "don't break userspace"?

AFAIK nothing is broken, but the messages are annoying. Especially since
99.9% of the time they're caused not by the applications but by glibc.
So the message should be heavily rate limited at least, if that's not
already done.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
