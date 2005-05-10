Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVEJRx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVEJRx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEJRx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:53:58 -0400
Received: from 68-190-178-40.cs-cres.charterpipeline.net ([68.190.178.40]:47369
	"EHLO gw.trlp.com") by vger.kernel.org with ESMTP id S261717AbVEJRxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:53:55 -0400
Date: Tue, 10 May 2005 10:52:57 -0700
From: James Washer <washer@trlp.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dipankar_dd@yahoo.com, akt-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Crashing red hat linux
Message-Id: <20050510105257.186d9403.washer@trlp.com>
In-Reply-To: <1115739760.12402.14.camel@mindpipe>
References: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
	<1115739760.12402.14.camel@mindpipe>
Organization: TRLP Inc
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why oh why would one do that?? 

On any recent redhat kernel, simply enable magic sysrq by:
	echo 1 > /proc/sys/kernel/sysrq

Then force a panic at the console by hitting ALT-SysRq-c
or by
	echo c > /proc/sysrq-trigger


On Tue, 10 May 2005 11:42:39 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2005-05-10 at 01:26 -0700, dipankar das wrote:
> > Hi
> >  Does Red hat like Monta vista allow crashing the
> > kernel by writing to  "/dev/crash" if not whats the
> > easiest way ?
> 
> cat /dev/dsp > /dev/kmem should do it.
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
