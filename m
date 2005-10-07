Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVJGXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVJGXrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVJGXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:47:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbVJGXrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:47:04 -0400
Date: Fri, 7 Oct 2005 16:46:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management [try #2]
Message-ID: <20051007234656.GJ5856@shell0.pdx.osdl.net>
References: <12790.1128728334@warthog.cambridge.redhat.com> <20051007233547.GH5856@shell0.pdx.osdl.net> <20051007220426.GC5856@shell0.pdx.osdl.net> <19008.1128699684@warthog.cambridge.redhat.com> <11615.1128694058@warthog.cambridge.redhat.com> <26883.1128700665@warthog.cambridge.redhat.com> <12605.1128728040@warthog.cambridge.redhat.com> <12936.1128728702@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12936.1128728702@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> 
> Hi Chris,
> 
> David Howells <dhowells@redhat.com> wrote:
> 
> > > I thought that too at first, which is why I flagged it at first.  But I
> > > think it's actually not a real problem, because isn't that !CONFIG_KEYS?
> > > So, I think it's just cosmetic.
> > 
> > It is a problem; at least I found it to be one. And no it isn't !CONFIG_KEYS.
> 
> It's not one I'd fixed earlier. I fixed the same problem, but in the dummy
> routines. It's contingent on CONFIG_KEYS and !CONFIG_SECURITY. Would you be
> willing to whip up a patch to change it? I'd do it, but I'm currently logged
> in on my laptop over a 9600 baud modem connection.

No problem.

thanks,
-chris
