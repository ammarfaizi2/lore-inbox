Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTERUvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTERUvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:51:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3955 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262196AbTERUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:51:42 -0400
Date: Sun, 18 May 2003 14:06:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: need better I/O scheduler for bulk file serving
Message-Id: <20030518140642.64c7d619.akpm@digeo.com>
In-Reply-To: <20030518195913.GA19275@codeblau.de>
References: <20030518195913.GA19275@codeblau.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2003 21:04:34.0173 (UTC) FILETIME=[154B02D0:01C31D81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-kernel@fefe.de> wrote:
>
> Larger read-ahead maybe?

Or an anticipatory scheduler.  You don't say what kernel you're
using.

We can set the readahead per-fd now, but the fcntl/ioctl hasn't
been implemented.
