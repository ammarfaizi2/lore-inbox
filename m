Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVHWUWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVHWUWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVHWUWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:22:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52727 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932368AbVHWUWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:22:21 -0400
Subject: Re: 2.6.12 Performance problems
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: danial_thom@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com>
References: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 13:22:16 -0700
Message-Id: <1124828536.15265.160.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 13:10 -0700, Danial Thom wrote:
> 
> None of this is helpful, but since no one has
> been able to tell me how to tune it to provide
> absolute priority to the network stack I'll
> assume it can't be done.

History has proven that camp wrong almost 100% of the time.

You were told to turn off kernel preemption. 

A diligent comparison requires that, since 2.4 does not support kernel
preemption, and a fair comparison requires holding all other things
constant.

In addition, there were several IP-level features mentioned in emails,
that have been added to 2.6.

You need to make sure those are all off by default, to keep your
comparison relevant.

All the answers are before you, review those emails, turn all that stuff
off and retest.




