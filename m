Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUBFJdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUBFJdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:33:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:22483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265356AbUBFJd2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:33:28 -0500
Date: Fri, 6 Feb 2004 01:35:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt <dirtbird@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-Id: <20040206013523.394d89f1.akpm@osdl.org>
In-Reply-To: <40235DCC.2060606@ntlworld.com>
References: <402359E1.6000007@ntlworld.com>
	<20040206011630.42ed5de1.akpm@osdl.org>
	<40235DCC.2060606@ntlworld.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt <dirtbird@ntlworld.com> wrote:
>
>  >But is there any application in which two threads simultaneously perform
>  >read() against the same fd which is not already buggy?
>  >
>  >
>  >  
>  >
>  touché :) but still we should do what we can.. want me to make a patch?

Not unless we can think of a way in which it actually matters, thanks.

