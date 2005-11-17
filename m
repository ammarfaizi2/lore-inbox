Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbVKQCKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbVKQCKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbVKQCKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:10:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030585AbVKQCKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:10:17 -0500
Date: Wed, 16 Nov 2005 18:09:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, az@bond.edu.au, linux-kernel@vger.kernel.org,
       keyrings@linux-nfs.org
Subject: Re: [PATCH] Keys: Permit key expiry time to be set
Message-Id: <20051116180941.57a604b8.akpm@osdl.org>
In-Reply-To: <25039.1132150357@warthog.cambridge.redhat.com>
References: <25039.1132150357@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>  The attached patch adds a new keyctl function that allows the expiry time to
>  be set on a key or removed from a key, provided the caller has attribute
>  modification access.

There is no need for the ability to query a key's timeout setting?
