Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbUKWAFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUKWAFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKWADh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:03:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:14553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262477AbUKWADD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:03:03 -0500
Date: Mon, 22 Nov 2004 16:07:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_ioperm() allows port offsets > 0x3ff
Message-Id: <20041122160710.47dfc778.akpm@osdl.org>
In-Reply-To: <200411221012_MC3-1-8F2C-FF44@compuserve.com>
References: <200411221012_MC3-1-8F2C-FF44@compuserve.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Is $SUBJECT a bug?  I can see the IO bitmap size was increased in June.
> 
> The latest ltp test suite expects offsets > 0x3ff to fail.

The size was increased to cover 64k in June of this year.
