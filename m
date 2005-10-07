Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVJGWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVJGWEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVJGWEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:04:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932678AbVJGWEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:04:40 -0400
Date: Fri, 7 Oct 2005 15:04:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management [try #2]
Message-ID: <20051007220426.GC5856@shell0.pdx.osdl.net>
References: <19008.1128699684@warthog.cambridge.redhat.com> <11615.1128694058@warthog.cambridge.redhat.com> <26883.1128700665@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26883.1128700665@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> +static inline int security_key_permission(key_ref_t key_ref,
> +					  struct task_struct *context,
> +					  key_perm_t perm)
> +{
> +	return -1;
> +}

No solid reason on that one, might as well be 0 for consistency.

Other than that, looks good.  It's going to conflict with some pending
changes I have, how shall we work that?  I can put all of these in that
queue?

thanks,
-chris
