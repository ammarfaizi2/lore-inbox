Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTDIVZY (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTDIVZY (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:25:24 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:21981 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263825AbTDIVZX (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:25:23 -0400
Subject: Re: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
From: Steven Cole <elenstev@mesatop.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <1049922707.24466.41.camel@spc9.esa.lanl.gov>
References: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
	 <1049921014.592.0.camel@teapot.felipe-alfaro.com>
	 <1049922707.24466.41.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1049924199.24466.51.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 09 Apr 2003 15:36:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 15:11, Steven Cole wrote:

> I also tried 2.5.67-ac1 which behaves the same as above, and
> 2.5.67-mm1 which does not hang, but reboots.  Adding akpm to
> the cc-list since -mm1 behaves a little differently than the rest.
> 
> I replaced id:5:initdefault: with id:3:initdefault: in /etc/inittab
> and that made the lockups go away with 2.5.67-[bk,ac1,mm1].  

Sorry, that last statement was a little vague.  I usually start X
with "startx", and that works fine with everything.  Hitting "Log Out"
kills X and gets me back to run level 3.  However, if I do a
/sbin/init 5, log in with the graphical login and then hit "Log Out",
the 2.5.67-[bk,ac1] kernels lock up and -mm1 reboots.

Steven


