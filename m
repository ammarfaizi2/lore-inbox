Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTETG6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTETG6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:58:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56625 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263600AbTETG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:58:15 -0400
Date: Tue, 20 May 2003 00:13:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: problem with sysfs symlink "fix"
Message-Id: <20030520001334.6f77d7ee.akpm@digeo.com>
In-Reply-To: <20030520001052.GA28067@kroah.com>
References: <20030520001052.GA28067@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 07:11:10.0049 (UTC) FILETIME=[FD56B510:01C31E9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Could your fix to fs/sysfs/symlink.c have caused this?

Yes.  I completely misread the code.  It needs to be reverted.
Sorry about that.

