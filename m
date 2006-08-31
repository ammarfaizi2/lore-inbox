Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWHaMrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHaMrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHaMrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:47:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40146 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932187AbWHaMrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:47:13 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15165.1157028169@warthog.cambridge.redhat.com> 
References: <15165.1157028169@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CacheFiles: Handle ENOSPC on create/mkdir better 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 13:47:02 +0100
Message-ID: <15265.1157028422@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Handle ENOSPC on create/mkdir calls to the backing filesystem better.  Rather
> than returning it to FS-Cache or FS-Cache returning it to the netfs, it is
> converted into ENOBUFS.

Signed-Off-By: David Howells <dhowells@redhat.com>

of course.
