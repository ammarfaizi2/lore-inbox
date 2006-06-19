Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWFSQAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWFSQAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWFSQAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:00:23 -0400
Received: from canuck.infradead.org ([205.233.218.70]:9608 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932526AbWFSQAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:00:22 -0400
Subject: Re: [PATCH 15/15] frv: clean frv unistd.h
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060619122516.10060.71734.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
	 <20060619122516.10060.71734.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 17:00:04 +0100
Message-Id: <1150732804.3176.450.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 13:25 +0100, David Howells wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Remove _syscall invocations that aren't used in the kernel.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-Off-By: David Howells <dhowells@redhat.com> 

In that case, you might as well remove the definitions of _syscall0,
_syscall1, etc. too. Nothing uses them now at all, does it?

-- 
dwmw2

