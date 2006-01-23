Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWAWUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWAWUZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWAWUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:25:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17062 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964927AbWAWUZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:25:43 -0500
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
	2.6.16-rc1-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <20060123210918.54d4fc75@localhost>
References: <43D00887.6010409@bigpond.net.au>
	 <20060121114616.4a906b4f@localhost> <43D2BE83.1020200@bigpond.net.au>
	 <20060123210918.54d4fc75@localhost>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 15:25:37 -0500
Message-Id: <1138047938.21481.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 21:09 +0100, Paolo Ornati wrote:
> However I've noticed that priority of X fluctuate a lot for unknown
> reasons...
> 
> When doing almost nothing it gets prio 6/7 but if I only move the
> cursor a bit it jumps up to ~29. 
> 
> If I'm running glxgears (with diret rendering ON) the priority stay to
> 6/7 and moving the cursor I'm only able to get priority 8.
> 
> Under load X priority goes up and it suffers (cursor jumps a bit).
> 
> IOW: strangeness! 

This seems right to me, how do you expect X to be treated by the
scheduler?

Lee

