Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUAOH0C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUAOH0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:26:02 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:50560 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266194AbUAOHZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:25:59 -0500
Date: Thu, 15 Jan 2004 08:26:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Same keyboard.c as in 2.6.0
Message-ID: <20040115072623.GB526@ucw.cz>
References: <1074124061.1278.5.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074124061.1278.5.camel@midux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 01:47:41AM +0200, Markus Hästbacka wrote:

> Hi list,
> I think many of you have run into this problem:
> Some of your keys doesn't work in 2.6.1. 
> 
> If you linux gurus know a better way to do this - please tell.
> 
> Compiled and tested against 2.6.1-bk2
> 

Please try latest 2.6.1-mm. It should be all fixed there.

Note that if just your extra special multimedia keys don't work in
2.6.1-mm, then that's intentional, and you'll have to use setkeycodes
to make them work. Maintaining all the special keys proved to be very
nightmarish for me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
