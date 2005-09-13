Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVIMTQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVIMTQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVIMTQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:16:04 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:7134 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S965056AbVIMTQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:16:02 -0400
Message-ID: <4327256E.2000702@compro.net>
Date: Tue, 13 Sep 2005 15:15:58 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net>	 <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>	 <4326DB8A.7040109@compro.net>	 <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>	 <4326EAD7.50004@compro.net> <1126632856.3455.45.camel@cog.beaverton.ibm.com>
In-Reply-To: <1126632856.3455.45.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.13.18
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:

> 
> But you don't really want to know HZ, you want to know timer resolution.
> That's a reasonable request and I believe the posix-timers
> clock_getres() interface might provide what you need. Although I'd defer
> to George (CC'ed) since he's more of an expert on those interfaces.
> 
> You might also want to check out his HRT patches.
> 
> thanks
> -john

Thanks John that does in fact seem to do what I needed. It gives me 
enough info that I can tell the HZ of the running kernel. HaHa...
I'm familiar with the HRT stuff as it was on the 2.4 kernel.

Thanks
Mark
