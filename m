Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUBJRgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266070AbUBJRf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:35:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:62922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266066AbUBJRfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:35:12 -0500
Date: Tue, 10 Feb 2004 09:37:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jeffchua@silk.corp.fedex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
Message-Id: <20040210093732.390721cb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
	<20040209225336.1f9bc8a8.akpm@osdl.org>
	<Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
	<20040210082514.04afde4a.akpm@osdl.org>
	<Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> So the rule should still be: don't include kernel headers from user 
>  programs. 

Yup.  I generally take the position that we should fix up things which used
to work, but which 2.6 broke.  Usually that is the only thing which people
care about anyway...

