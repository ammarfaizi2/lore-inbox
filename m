Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbTJTU1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJTU1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:27:54 -0400
Received: from [65.172.181.6] ([65.172.181.6]:27081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262757AbTJTU1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:27:53 -0400
Date: Mon, 20 Oct 2003 13:28:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ken Foskey <foskey@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K 2.6 test6 strange signal behaviour
Message-Id: <20031020132805.5e5a59f1.akpm@osdl.org>
In-Reply-To: <1066654886.5930.57.camel@gandalf.foskey.org>
References: <1066654886.5930.57.camel@gandalf.foskey.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Foskey <foskey@optushome.com.au> wrote:
>
> I have a problem with signals.

You should be using sigsetjmp(), not setjmp().

