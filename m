Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWBXWdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWBXWdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBXWdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:33:00 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:44252 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932497AbWBXWc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:32:59 -0500
From: Grant Coady <gcoady@gmail.com>
To: Bryan Fink <bfink@eventmonitor.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS Still broken in 2.6.x?
Date: Sat, 25 Feb 2006 09:32:50 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <l32vv1pfjr5n9eeuouqu7n23r7lu4p1njn@4ax.com>
References: <43FE1CAD.3050806@eventmonitor.com>	<1140734824.7963.38.camel@lade.trondhjem.org> <20060224041435.733b4f0d.akpm@osdl.org> <43FF31E4.2000705@eventmonitor.com>
In-Reply-To: <43FF31E4.2000705@eventmonitor.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 11:18:44 -0500, Bryan Fink <bfink@eventmonitor.com> wrote:

>Hi again. I just found some new, very interesting information. Until 
>just a few minutes ago, I hadn't realized that one could change the I/O 
>scheduler at runtime. Looking into it, my system was using "cfq", and I 
>have three other options, "noop", "anticipatory", and "deadline". I've 
>now run tests using all three of the other schedulers, and they all 
>bring performance back up to the level I had with kernel 2.4. So, either 
>NFS is incompatible with cfq, or cfq has some issues that show very 
>vividly when used with NFS (or, I suppose, I just have my system tuned 
>wrong for use with cfq).

I run NFS for ages -- all linux boxen here mount a shared export from 
localnet controller box to get source + patches.

Only have 'deadline' installed on 2.6 kernels -- not seen any problems 
with NFS here (apart from back when I had data corruption due a faulty 
memory stick).

Grant.
