Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUCVPdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUCVPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:33:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:16046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262056AbUCVPdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:33:42 -0500
Date: Mon, 22 Mar 2004 07:33:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: piotr@larroy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1
Message-Id: <20040322073327.754a5b42.akpm@osdl.org>
In-Reply-To: <20040322125305.GA2306@larroy.com>
References: <20040316015338.39e2c48e.akpm@osdl.org>
	<20040322125305.GA2306@larroy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

piotr@larroy.com (Pedro Larroy) wrote:
>
> Where would kernel leaked ram be accounted?

/proc/meminfo, /proc/vmstat and /proc/slabinfo.  Also sysrq-M.
