Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTHYQ6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbTHYQ6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:58:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:47849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261960AbTHYQ6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:58:00 -0400
Date: Mon, 25 Aug 2003 09:53:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: where is /proc/acpi/sleep?
Message-Id: <20030825095309.142c9f2f.rddunlap@osdl.org>
In-Reply-To: <1061640857.709.1.camel@teapot.felipe-alfaro.com>
References: <1061640857.709.1.camel@teapot.felipe-alfaro.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 14:14:18 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

| Hi!
| 
| I can't suspend (or software suspend) my laptop since I can't find
| /proc/acpi/sleep anymore while running 2.6.0-test4. How can I suspend to
| S3 or S4?

Comments in the BK changesets say:

[acpi] Remove procfs sleep interface.

Use /sys/power/state instead.


--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."
