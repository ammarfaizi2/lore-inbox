Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUG1UqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUG1UqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUG1UqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:46:21 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:37394 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S263740AbUG1UqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:46:11 -0400
Date: Wed, 28 Jul 2004 13:46:03 -0700
To: Lee Revell <rlrevell@joe-job.com>
Cc: Bill Huey <bhuey@lnxw.com>, karim@opersys.com,
       Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728204603.GA7106@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys> <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe> <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe> <20040728202107.GA6952@nietzsche.lynx.com> <1091047369.791.35.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091047369.791.35.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 04:42:51PM -0400, Lee Revell wrote:
> As I understand it there will still be a place for the current hard-RT
> Linux solutions, because even if I can get five nines latency better
> than N, this is not good enough for hard RT, as you need to be able to
> mathematically demonstrate that you can *never* miss a deadline.
> 
> Or are you saying that the latest developments in the stock kernel make
> this possible?

Not quite with this thread and in this stage of development, but this is
quite possible if certain concurrency problems are solved in Linux. RCU is
a potential pain as well as other things. BSD/OS-FreeBSD-current are not
new to this kind of conversion, so this is certainly very possible with
very finite software engineering problems to solve. 

Scary ain't it ? It makes me wonder some times.

bill

