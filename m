Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTDZXrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTDZXrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 19:47:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2688 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261528AbTDZXrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 19:47:10 -0400
Date: Sun, 27 Apr 2003 00:59:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow ptrace and /proc/PID/mem to read fixmap pages
Message-ID: <20030426235921.GB1494@mail.jlokier.co.uk>
References: <200304262346.h3QNkL129881@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304262346.h3QNkL129881@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
> This patch is i386-specific and should probably be done another way, but
> it's what I am using now.  It works and is well-tested. 

Would it be better to simply check whether _PAGE_USER is set in the pte?

-- Jamie
