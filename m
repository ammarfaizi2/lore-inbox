Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTDPKAz (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTDPKAz 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:00:55 -0400
Received: from [12.47.58.203] ([12.47.58.203]:53473 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264282AbTDPKAx (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 06:00:53 -0400
Date: Wed, 16 Apr 2003 03:13:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: 76306.1226@compuserve.com, mru@users.sourceforge.net,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: DMA transfers in 2.5.67
Message-Id: <20030416031303.76779cac.akpm@digeo.com>
In-Reply-To: <20030416031144.613b0cc7.akpm@digeo.com>
References: <200304160548_MC3-1-349F-E844@compuserve.com>
	<20030416031144.613b0cc7.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 10:12:41.0038 (UTC) FILETIME=[B6D43EE0:01C30400]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > # mount /ext3_fs
> > # time dd if=/ext3_fs/100MiB_file of=/dev/null bs=32k
> > 
> >   2.4.20aa1 : 3.3 sec (exactly what I expect to see)
> >   2.5.66    : 6.6 sec
> 
> With this test 2.4 will leave a lot more unwritten dirty data in memory.
> 
> You should include a `sync' in the timings.

Well you should include the sync if you're writing to disk ;)

doh.

