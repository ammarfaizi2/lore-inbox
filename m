Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUFUXZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUFUXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUFUXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:31698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266525AbUFUXZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:25:24 -0400
Date: Mon, 21 Jun 2004 16:22:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: geoffrey.levand@am.sony.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-Id: <20040621162248.3709f634.rddunlap@osdl.org>
In-Reply-To: <20040621161306.1d6bff5c@dell_ss3.pdx.osdl.net>
References: <40C7BE29.9010600@am.sony.com>
	<20040621161306.1d6bff5c@dell_ss3.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 16:13:06 -0700 Stephen Hemminger wrote:

| A couple of comments on posix-hrt-core-04.06.09.patch

I haven't looked at the full patch lately, but...

| 3. The IF_HIGH_RES() macro looks cute, but get confusing, and makes the code
|    less readable.

this macro was always ugly and obfuscating to me.
Definitely need to lose it.

--
~Randy
