Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTHLVmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271185AbTHLVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:42:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:8422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271184AbTHLVmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:42:38 -0400
Date: Tue, 12 Aug 2003 14:28:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-Id: <20030812142846.46eacc48.akpm@osdl.org>
In-Reply-To: <3F3951F1.9040605@tupshin.com>
References: <3F3951F1.9040605@tupshin.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tupshin Harper <tupshin@tupshin.com> wrote:
>
> raid0_make_request bug: can't convert block across chunks or bigger than 
> 8k 12436792 8

There is a fix for this at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1/broken-out/bio-too-big-fix.patch

Results of testing are always appreciated...
