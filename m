Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbTCDNMt>; Tue, 4 Mar 2003 08:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269418AbTCDNMt>; Tue, 4 Mar 2003 08:12:49 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:28306 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S269417AbTCDNMt>;
	Tue, 4 Mar 2003 08:12:49 -0500
Subject: Re: [CHECKER] potential races in kernel/*.c mm/*.c net/*ipv4*.c
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <200303041112.h24BCRW22235@csl.stanford.edu>
References: <200303041112.h24BCRW22235@csl.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046784189.31624.76.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Mar 2003 14:23:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 12:12, Dawson Engler wrote:
> Hi All,
> 
> here are a few more potential races from checking the directories:
> 	kernel/*.c
> 	mm/*.c
> 	net/*ipv4*.c
> 	arch/i386/kernel/*.c
> 
> which seem relatively more important that other directories.  [If there
> are other subdirs that a worth checking let me know --- I am trying to
> ensure that if we release race bugs someone will care enough to look
> at them.]

It would be great if you could check net/{ipv4,ipv6}/netfilter/*.c and
send the results to lkml and netfilter-devel@lists.netfilter.org

Thanks in advance.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
