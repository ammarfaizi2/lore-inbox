Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVCWVKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVCWVKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVCWVKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:10:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:59569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262923AbVCWVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:07:51 -0500
Date: Wed, 23 Mar 2005 13:07:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Keys: Use RCU to manage session keyring pointer
Message-Id: <20050323130724.1aacfcf3.akpm@osdl.org>
In-Reply-To: <29285.1111609185@redhat.com>
References: <29204.1111608899@redhat.com>
	<29285.1111609185@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch uses RCU to manage the session keyring pointer in struct
>  signal_struct.

So are these patches dependent upon the
keys-use-rcu-to-manage-session-keyring-pointer work?
