Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUCATZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCATZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:25:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:1432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbUCATZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:25:07 -0500
Date: Mon, 1 Mar 2004 11:24:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FASTBOOT options in EMBEDDED menu?
Message-Id: <20040301112435.66be3bcc.rddunlap@osdl.org>
In-Reply-To: <40438CDB.9080003@am.sony.com>
References: <40438CDB.9080003@am.sony.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 11:19:55 -0800 Tim Bird wrote:

| I'm starting to adapt some patches for options which
| allow Linux to boot faster (for embedded environments).
| 
| It seems like these should go under the EMBEDDED
| menu.  However, this menu looks like it is specific
| to size reductions:
| 
| menuconfig EMBEDDED
|      bool "Remove kernel features (for embedded systems)"
|      help
|        This option allows certain base kernel features to be removed from
|        the build...
| 
| Some of the options that CELF is working on for
| fast booting do remove features, but some do not.
| 
| Anyone have advice for whether I should:
| 1) use the existing EMBEDDED option (my preference), or
| 2) make a new FASTBOOT option?

I agree with you, EMBEDDED should be able to handle it.

--
~Randy
