Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272599AbTG1Dnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272638AbTG1Dnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:43:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:18334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272599AbTG1Dnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:43:55 -0400
Date: Sun, 27 Jul 2003 20:59:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marino Fernandez <mjferna@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory runs out fast with 2.6.0-test2 (and test1)
Message-Id: <20030727205912.1bb4a635.akpm@osdl.org>
In-Reply-To: <200307272117.23398.mjferna@yahoo.com>
References: <200307272117.23398.mjferna@yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marino Fernandez <mjferna@yahoo.com> wrote:
>
> Everything works OK in my system... my only gripe is that I run out of memory 
>  quickly.

Please monitor /proc/meminfo and /proc/slabinfo, see if you can work out
where the memory has gone and post the results.

What filesystems are you using there?
