Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSJURaJ>; Mon, 21 Oct 2002 13:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSJURaJ>; Mon, 21 Oct 2002 13:30:09 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:22029 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261574AbSJURaI>; Mon, 21 Oct 2002 13:30:08 -0400
Date: Mon, 21 Oct 2002 18:36:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Wray <mike_wray@hp.com>
Cc: Stephen Smalley <sds@tislabs.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021021183612.A24301@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Wray <mike_wray@hp.com>, Stephen Smalley <sds@tislabs.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.33.0210181239310.9847-100000@raven> <003701c27909$7367e350$6345900f@hpl.hp.com> <20021021150920.A14396@infradead.org> <007801c27921$28e1bf00$6345900f@hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <007801c27921$28e1bf00$6345900f@hpl.hp.com>; from mike_wray@hp.com on Mon, Oct 21, 2002 at 05:44:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:44:15PM +0100, Mike Wray wrote:
> I'm not sure what was conceptually wrong. There are other multiplexing
> syscalls
> in the kernel - so the concept of multiplexing cannot be wrong?
> Or is setsockopt broken too?

It is conceptually wrong, yes.  Just because a mistake has been made
in the past there's no real reason to repeat it.

> Netfilter provides nf_register_sockopt() to allow open-ended registration
> of socket-opt handling by a module - without any review. So do many other
> kernel interfaces.

socket-opt handling does not come with different argument types.

