Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271888AbRIEJwM>; Wed, 5 Sep 2001 05:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271892AbRIEJwC>; Wed, 5 Sep 2001 05:52:02 -0400
Received: from ns.suse.de ([213.95.15.193]:60420 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271888AbRIEJvu>;
	Wed, 5 Sep 2001 05:51:50 -0400
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Sep 2001 11:52:09 +0200
In-Reply-To: Florian Weimer's message of "5 Sep 2001 11:22:44 +0200"
Message-ID: <oupae0ax8vq.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE> writes:

> Would anyone like to give me a helping hand in implementing the
> getpeereid() syscall for Linux?  See the following page for the
> documentation of the OpenBSD implementation:

It is implemented for unix sockets (see unix(7))
For TCP it is rather useless because it would work only locally. If you trust
the localhost you're probably better off using the ident protocol for it.

-Andi

