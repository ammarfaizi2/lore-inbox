Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTIVVOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbTIVVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:14:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:12706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263282AbTIVVOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:14:35 -0400
Date: Mon, 22 Sep 2003 13:54:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: rjwalsh@durables.org, wangdi@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kgdb-over-ethernet using netpoll api
Message-Id: <20030922135456.74890771.akpm@osdl.org>
In-Reply-To: <20030922184738.GM2414@waste.org>
References: <20030922184738.GM2414@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  l-mpm/include/asm/kgdb.h                  |   11 

Please don't generate diffs against `include/asm/foo.h': things tend to
turn rather ugly when the symlink doesn't exist, or points at a different
architecture's include directory...


