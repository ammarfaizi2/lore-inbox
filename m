Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUFVL1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUFVL1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 07:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFVL1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 07:27:46 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:49170 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262422AbUFVL1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 07:27:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Hannu Savolainen <hannu@opensound.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Stop the Linux kernel madness
Date: Tue, 22 Jun 2004 14:19:46 +0300
X-Mailer: KMail [version 1.4]
Cc: 4Front Technologies <dev@opensound.com>,
       David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <20040622020615.GE14478@dualathlon.random> <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406221419.46035.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 10:54, Hannu Savolainen wrote:
> In the long term frequent changes in kernel interfaces cause problems
> because drivers that try to stay compatible with as many kernel versions
> as possible will start looking like #ifdef spaghetti.

What's the point in staying "compatible with as many kernels versions
as possible"? IMHO it's enough to be able to build and work
with latest 2.6, latest 2.4 and maybe latest 2.2. Not _that_
much of #ifdefs.

(/me was looking into ntp code recently. *That* is #ifdef hell)
--
vda
