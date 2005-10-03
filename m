Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVJCGI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVJCGI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVJCGI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:08:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932112AbVJCGI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:08:59 -0400
Date: Mon, 3 Oct 2005 02:08:32 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: liixixi <avlimeng@kingsoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: pthread question
Message-ID: <20051003060832.GG8983@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <003c01c5c7de$63716490$6515a8c0@antivirus.rdev.kingsoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01c5c7de$63716490$6515a8c0@antivirus.rdev.kingsoft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 01:50:41PM +0800, liixixi wrote:
> Hi:
>     I have a question in using pthread_join, when I program in windows, I
> can call WaitForSingleObject to wait another thread exit, I can pass a
> time-out to WaitForSingleObject, but, with pthread_join, I can't do the same
> thing like WaitForSingleObject, any ideas? thx.

This has nothing to do with linux-kernel, so the question should go to a
different list.
If you are using NPTL, you can use pthread_timedjoin_np.

	Jakub
