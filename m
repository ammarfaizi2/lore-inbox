Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbTC0QPO>; Thu, 27 Mar 2003 11:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbTC0QPN>; Thu, 27 Mar 2003 11:15:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263277AbTC0QPM>;
	Thu, 27 Mar 2003 11:15:12 -0500
Date: Thu, 27 Mar 2003 08:22:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-Id: <20030327082212.252159e0.rddunlap@osdl.org>
In-Reply-To: <20030327160220.GA29195@work.bitmover.com>
References: <20030324212813.GA6310@osiris.silug.org>
	<20030324180107.A14746@vger.timpanogas.org>
	<20030324234410.GB10520@work.bitmover.com>
	<20030324182508.A15039@vger.timpanogas.org>
	<20030327160220.GA29195@work.bitmover.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003 08:02:20 -0800 Larry McVoy <lm@bitmover.com> wrote:

| I'm getting these on the machine we use to do the BK->CVS conversions.
| My guess is that this means there was a memory error and ECC fixed it.
| The only problem is that I'm reasonably sure that there isn't ECC on
| these DIMMs.  Does anyone have the table of error codes to explanations?
| Google didn't find anything for this one.
| 
| Thanks.
| 
| Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
| slovax kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
| 
| Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
| slovax kernel: Bank 1: 9000000000000151

You can try the Dave Jones "parsemce" tool on it, from
  http://www.codemonkey.org.uk/cruft/parsemce.c/

--
~Randy
