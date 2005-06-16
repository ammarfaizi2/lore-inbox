Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVFPQFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVFPQFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFPQFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 12:05:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54932 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261731AbVFPQFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 12:05:02 -0400
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
From: Lee Revell <rlrevell@joe-job.com>
To: Patrik =?ISO-8859-1?Q?H=E4gglund?= <patrik.hagglund@bredband.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42B199FF.5010705@bredband.net>
References: <42B199FF.5010705@bredband.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 16 Jun 2005 12:01:58 -0400
Message-Id: <1118937719.2644.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 17:25 +0200, Patrik Hägglund wrote:
> For example, in one virtual 
> terminal I stared a "supervisor" shell with SCHED_FIFO at priority
> 20, 
> and then the job tasks I wanted to "run" in other virtual terminals,
> now 
> still with SCHED_FIFO, but with lower priorities. 

I believe there's a Sysrq to drop all SCHED_FIFO processes to
SCHED_OTHER.  But yes, in general, bad things will happen if you are not
careful with SCHED_FIFO.

Lee

