Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWCaKIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWCaKIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCaKIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:08:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9390
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932077AbWCaKHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:07:35 -0500
Date: Fri, 31 Mar 2006 02:07:27 -0800 (PST)
Message-Id: <20060331.020727.122135042.davem@davemloft.net>
To: adrian@smop.co.uk
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060331095443.GA8616@smop.co.uk>
References: <20060331072859.GA5389@smop.co.uk>
	<20060330.234823.109651253.davem@davemloft.net>
	<20060331095443.GA8616@smop.co.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bridgett <adrian@smop.co.uk>
Date: Fri, 31 Mar 2006 10:54:43 +0100

> On Thu, Mar 30, 2006 at 23:48:23 -0800 (-0800), David S. Miller wrote:
> > As I stated, there was a bug in the initial patch, which subsequent
> > patches fix.
> > 
> > Can you try Linus's current tree to see if the problem is there?
> 
> 2-6-16-git18 still has the problem (30th March).

Strange, can you strace the process and follow the socket
operations your application performs?  Something unique
is occuring in that app since there have not been other
reports of this problem that I am aware of.

Thanks.
