Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWDUANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWDUANX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWDUANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:13:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932161AbWDUANW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:13:22 -0400
Date: Thu, 20 Apr 2006 17:12:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] FS-Cache: Provide a filesystem-specific sync'able
 page bit
Message-Id: <20060420171216.4cdd369a.akpm@osdl.org>
In-Reply-To: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>   #define PG_checked		 8	/* kill me in 2.5.<early>. */
>  +#define PG_fs_misc		 8

It would be better to rename PG_checked to PG_fs_misc kernel-wide.
