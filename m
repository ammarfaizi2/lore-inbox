Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTHWRAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTHWQ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:59:21 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:54192 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263059AbTHWP4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:56:06 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sat, 23 Aug 2003 17:56:04 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-Id: <20030823175604.1ddb119d.skraw@ithnet.com>
In-Reply-To: <20030823151315.GA6781@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org>
	<20030823040931.GA3872@atj.dyndns.org>
	<20030823052633.GA4307@atj.dyndns.org>
	<20030823122813.0c90e241.skraw@ithnet.com>
	<20030823151315.GA6781@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 00:13:15 +0900
TeJun Huh <tejun@aratech.co.kr> wrote:

>  Hello, Stephan.
> 
>  The race conditions I'm mentioning in this thread are not likely to
> cause real troubles.  The first one does not make any difference on
> x86, and AFAIK bh isn't used extensively anymore so the second one
> isn't very relevant either.  Only the race condition mentioned in the
> other thread is of relvance if there is any :-(.

Are you sure? bh is used in fs subtree to my knowledge ...

Regards,
Stephan

