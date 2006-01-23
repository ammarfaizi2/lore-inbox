Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWAWVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWAWVJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWAWVJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:09:34 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:14485 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030186AbWAWVJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:09:33 -0500
Date: Mon, 23 Jan 2006 22:10:17 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
 2.6.16-rc1-mm1
Message-ID: <20060123221017.2d393c83@localhost>
In-Reply-To: <1138049979.21481.25.camel@mindpipe>
References: <43D00887.6010409@bigpond.net.au>
	<20060121114616.4a906b4f@localhost>
	<43D2BE83.1020200@bigpond.net.au>
	<20060123210918.54d4fc75@localhost>
	<1138047938.21481.11.camel@mindpipe>
	<20060123215231.04b38886@localhost>
	<1138049979.21481.25.camel@mindpipe>
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 15:59:38 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> > Maybe this is normal and depends on the way X sleeps or something...
> > 
> 
> Because the scheduler favors interactive tasks (aka those which spend a
> large % of time waiting on external events) and X is only considered
> interactive when the mouse is being moved.  When glxgears is running
> it's CPU bound and is therefore penalized.

??

The reverse... lower priority number means BETTER priority. So Actually
X is penalized when I'm moving the mouse.

And running "glxgears" doesn't make X CPU bounded if direct rendering
is enabled -- it is GPU bounded...

In fact I can run "glxgears" and still have 97% of IDLE CPU time.

-- 
	Paolo Ornati
	Linux 2.6.16-rc1-plugsched on x86_64
