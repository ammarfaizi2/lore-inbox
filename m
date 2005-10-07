Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVJGXqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVJGXqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVJGXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:46:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964883AbVJGXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:46:17 -0400
Date: Fri, 7 Oct 2005 16:46:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management [try #2]
Message-ID: <20051007234607.GI5856@shell0.pdx.osdl.net>
References: <20051007233547.GH5856@shell0.pdx.osdl.net> <20051007220426.GC5856@shell0.pdx.osdl.net> <19008.1128699684@warthog.cambridge.redhat.com> <11615.1128694058@warthog.cambridge.redhat.com> <26883.1128700665@warthog.cambridge.redhat.com> <12605.1128728040@warthog.cambridge.redhat.com> <12790.1128728334@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12790.1128728334@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> 
> > I thought that too at first, which is why I flagged it at first.  But I
> > think it's actually not a real problem, because isn't that !CONFIG_KEYS?
> > So, I think it's just cosmetic.
> 
> It is a problem; at least I found it to be one. And no it isn't !CONFIG_KEYS.

Ah, right, that's the other ifdef there.
