Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTJJFvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJJFvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:51:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262441AbTJJFvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:51:13 -0400
Date: Thu, 9 Oct 2003 22:45:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo.tosatti@cyclades.com, willy@w.ods.org, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: iproute2 not compiling anymore
Message-Id: <20031009224535.73a936e4.davem@redhat.com>
In-Reply-To: <20031010001352.GA2728@pcw.home.local>
References: <20031005130044.GA8861@pcw.home.local>
	<Pine.LNX.4.44.0310091051240.3040-100000@logos.cnet>
	<20031010001352.GA2728@pcw.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 02:13:52 +0200
Willy TARREAU <willy@w.ods.org> wrote:

> I'm too tired to investigate more, so I should do it tomorrow. Here is the
> compilation output, just in case it helps David. Please ask for .config if
> needed, but I don't think so.

I know what's wrong, linux/in.h needs to include linux/socket.h
Duh, I'll fix this up.
