Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUK2PRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUK2PRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUK2PRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:17:43 -0500
Received: from [213.146.154.40] ([213.146.154.40]:60358 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261724AbUK2PRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:17:42 -0500
Date: Mon, 29 Nov 2004 15:17:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] dynamic syscalls revisited
Message-ID: <20041129151741.GA5514@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1101741118.25841.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101741118.25841.40.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:11:58AM -0500, Steven Rostedt wrote:
> Before you just ignore me and throw me to the dogs, hear me out. Please!
> 
> I've seen previous attempts to get dynamic system calls into the kernel
> and they just get dumped, but usually with good reason.  They require a
> change to all architectures quite drastically and is usually a problem
> implementing them for the module to use them.

Actually they were dumped because dynamically syscalls are a really bad
idea, not because of implementation issues.

