Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTIXANn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbTIXANn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:13:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:57765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbTIXANm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:13:42 -0400
Date: Tue, 23 Sep 2003 17:15:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: zanussi@comcast.net, Ruth.Ivimey-Cook@ivimey.org, j.grootheest@euronext.nl,
       willy@w.ods.org, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-Id: <20030923171505.2a8d23bb.akpm@osdl.org>
In-Reply-To: <20030923222229.GQ1269@velociraptor.random>
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org>
	<3F708576.4080203@comcast.net>
	<20030923175320.GD1269@velociraptor.random>
	<20030923143754.6b9efbc9.akpm@osdl.org>
	<20030923222229.GQ1269@velociraptor.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> +__setup("log_buf_len=", log_buf_len_setup);

Specifying this in units of bytes is a pain.

How about we make it "log_buf_kbytes", and multiply it by 1024?


