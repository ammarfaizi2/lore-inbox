Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSJUODi>; Mon, 21 Oct 2002 10:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSJUODi>; Mon, 21 Oct 2002 10:03:38 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:59659 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261391AbSJUODi>; Mon, 21 Oct 2002 10:03:38 -0400
Date: Mon, 21 Oct 2002 15:09:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Wray <mike_wray@hp.com>
Cc: Stephen Smalley <sds@tislabs.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021021150920.A14396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Wray <mike_wray@hp.com>, Stephen Smalley <sds@tislabs.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.33.0210181239310.9847-100000@raven> <003701c27909$7367e350$6345900f@hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003701c27909$7367e350$6345900f@hpl.hp.com>; from mike_wray@hp.com on Mon, Oct 21, 2002 at 02:54:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 02:54:33PM +0100, Mike Wray wrote:
> I'm not sure the case for removal has been made. Some potential problems
> with the LSM security syscall have been pointed out. Isn't it better to
> consider
> fixes instead of ditching the syscall?

The conceptual wrong design was pointed out, yes.  It's not fixable
without rplacing it with a proper design of the security module entry
points.

> Won't the absence of the syscall just result
> in even worse code being used? Presumably SELinux will have to implement
> the syscall functionality some other way.

Unlike this hook there is a chance we can review their new creations when
they ask for inclusion.

