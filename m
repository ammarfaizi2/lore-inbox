Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUKBTvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUKBTvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbUKBTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:45:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:48774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261959AbUKBTlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:41:01 -0500
Date: Tue, 2 Nov 2004 12:39:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2 and processes in D state
Message-Id: <20041102123911.536fcc8e.akpm@osdl.org>
In-Reply-To: <200411021612.41974.l_allegrucci@yahoo.it>
References: <200411021612.41974.l_allegrucci@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
>
> 100% reproducible running LTP's 'runalltests.sh -x 100'.
>  Below is the SysRq+T log after init 1 (to kill all killable processes).
>  The processes which are stuck in D state are "genfmod" and "genlgamma".
>  2.6.9 seems not to be affected.  2.6.10-rc1-bk* not tried.

Which filesystem is in use?
