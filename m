Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTJOXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTJOXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:12:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:29351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262546AbTJOXMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:12:55 -0400
Date: Wed, 15 Oct 2003 16:12:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-Id: <20031015161251.7de440ab.akpm@osdl.org>
In-Reply-To: <20031015225055.GS17986@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> the patch below adds a configuration option for -Os

Two problems:

a) It adds yet another reason why person A discovers problems which
   person B cannot reproduce.

b) It adds yet another reason why person A cannot work out the exact
   file-n-line where person B's kernel oopsed.

They are small concerns really, but it does make one wonder why we should
not make this change unconditional: just switch the kernel to -Os?

Does anyone have any (non-micro-)benchmark results which say this is a bad
idea?

