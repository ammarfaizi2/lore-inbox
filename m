Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUJMQxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUJMQxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUJMQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:53:25 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:36061 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269751AbUJMQxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:53:13 -0400
Message-ID: <f44c5fdf0410130953288fee0c@mail.gmail.com>
Date: Wed, 13 Oct 2004 18:53:12 +0200
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Reply-To: Radoslaw Szkodzinski <astralstorm@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T9
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <20041013061518.GA1083@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 08:15:18 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i've uploaded the -T9 VP patch:
> 

There are lots of similar warnings in Reiser4:
  CC      fs/reiser4/plugin/node/node.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/plugin/node/../../reiser4.h:13,
                 from fs/reiser4/plugin/node/../../debug.h:9,
                 from fs/reiser4/plugin/node/node.c:47:
include/asm/mutex.h:75:5: warning: "RWSEM_DEBUG" is not defined

Also, there is an easy to fix compile error - redefinition of
inode_lock in fs/reiser4/plugin/object.c
