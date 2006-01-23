Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWAWUvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWAWUvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWAWUvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:51:48 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:34533 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932472AbWAWUvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:51:47 -0500
Date: Mon, 23 Jan 2006 21:52:31 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
 2.6.16-rc1-mm1
Message-ID: <20060123215231.04b38886@localhost>
In-Reply-To: <1138047938.21481.11.camel@mindpipe>
References: <43D00887.6010409@bigpond.net.au>
	<20060121114616.4a906b4f@localhost>
	<43D2BE83.1020200@bigpond.net.au>
	<20060123210918.54d4fc75@localhost>
	<1138047938.21481.11.camel@mindpipe>
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 15:25:37 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> This seems right to me, how do you expect X to be treated by the
> scheduler?

Why moving the mouse a little (that causes a microscopic % of CPU
being used) makes X priority jump up to 29 from 6/7 ???

And why this doesn't happen when glxgears (for example) is running?
(under cpu load this is different, with X never getting "good"
priority -- if I remember correctly)

Maybe this is normal and depends on the way X sleeps or something...

I don't know much about schedulers but if I'm able to make the cursor
going in jerks with just a bit of CPU load (linux$ make -j16, for
example) I wonder why X cannot get a better priority...

-- 
	Paolo Ornati
	Linux 2.6.16-rc1-plugsched on x86_64
