Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269760AbRHILMV>; Thu, 9 Aug 2001 07:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269763AbRHILML>; Thu, 9 Aug 2001 07:12:11 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:35971 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S269760AbRHILL6>; Thu, 9 Aug 2001 07:11:58 -0400
Date: Thu, 9 Aug 2001 21:11:23 +1000
From: john slee <indigoid@higherplane.net>
To: Yasunori GOTO <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file access log
Message-ID: <20010809211123.A3197@higherplane.net>
In-Reply-To: <0GHS003EV4XX9D@fjmail504.fjmail.jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0GHS003EV4XX9D@fjmail504.fjmail.jp.fujitsu.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 11:45:00AM +0900, Yasunori GOTO wrote:
> I want to make the function which check the file access
> (create(), unlink(), and rename(), etc.)
> and take the log.

there are many applications for this sort of kernel interface.  sgi have
an implementation of it called imon, but the patches don't seem to be
maintained anymore.

what sort of interface were you considering?  my first impression was to
create something similar to route sockets, but i'm not really a kernel
hacker...  i believe imon+fam used something like this but also using
fcntl() hacks, which to me seems a bit ugly... anyone want to correct
me? :-/

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
