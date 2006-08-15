Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWHOHvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWHOHvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWHOHvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:51:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965282AbWHOHvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:51:04 -0400
Date: Tue, 15 Aug 2006 00:51:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrzej Szymanski <szymans@agh.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
Message-Id: <20060815005100.be613254.akpm@osdl.org>
In-Reply-To: <20060815005025.22e8adfe.akpm@osdl.org>
References: <44E0A69C.5030103@agh.edu.pl>
	<20060815005025.22e8adfe.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 00:50:25 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Mounting with `-o writeback' should help.

err, `-o data=writeback'
