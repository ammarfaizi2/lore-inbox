Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTJUQUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTJUQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:20:11 -0400
Received: from [65.172.181.6] ([65.172.181.6]:17358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263162AbTJUQUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:20:08 -0400
Date: Tue, 21 Oct 2003 09:18:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] must fix lists
Message-Id: <20031021091827.0c58065e.rddunlap@osdl.org>
In-Reply-To: <3F94C833.8040204@cyberone.com.au>
References: <3F94C833.8040204@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 15:46:27 +1000 Nick Piggin <piggin@cyberone.com.au> wrote:

| The following people have their names in Documentation/must-fix.txt. Lots
| of others in should-fix.txt in 2.6.0-test8-mm1. Please review your entries.
| Also, please add any other substantial changes you need before 2.6. Thanks.


In the should-fix.txt file:

o viro: cleaning up options-parsers in filesystems.  (patch exists, needs
  porting).

The parser lib functions are merged and approx. 15 filesystems
have been converted to use it, so this could be changed to:

o viro: convert more filesystems to use lib/parser.c for parsing options
(still PRI2 I suppose)

--
~Randy
