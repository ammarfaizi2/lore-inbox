Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285422AbRLSTdb>; Wed, 19 Dec 2001 14:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285427AbRLSTdV>; Wed, 19 Dec 2001 14:33:21 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:52376 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S285422AbRLSTdL>; Wed, 19 Dec 2001 14:33:11 -0500
Date: Wed, 19 Dec 2001 14:49:18 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: devik <devik@cdi.cz>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
In-Reply-To: <Pine.LNX.4.33.0112191508060.2688-100000@devix>
Message-ID: <Pine.LNX.4.40.0112191448200.5242-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, devik wrote:

> Hello,
> just another crash report. But interesting one IMHO.
> When I compile 2.3.16/SMP with gcc 3.0.2 then it works.
> But when I changed -O2 to -O (compile speed reasons)
> the compilation succeeded but kernel crashed during
> boot (in sys_sigreturn).

The kernel relies on features turned on by -O2 and will not function
properly with just -O of any version of gcc.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

