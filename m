Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143866AbRAHPUC>; Mon, 8 Jan 2001 10:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143970AbRAHPTw>; Mon, 8 Jan 2001 10:19:52 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:20824 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S143866AbRAHPTi>; Mon, 8 Jan 2001 10:19:38 -0500
Date: Mon, 8 Jan 2001 17:26:42 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Chris Meadors <clubneon@hereintown.net>
cc: "David S. Miller" <davem@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.31.0101080918260.17858-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.4.21.0101081725250.10084-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Chris Meadors wrote:

> On Mon, 8 Jan 2001, David S. Miller wrote:
> 
> > This definitely seems like the classic "/etc/nsswitch.conf is told to
> > look for YP servers and you are not using YP", so have a look and fix
> > nsswitch.conf if this is in fact the problem.
> 
> What I have never gotten, is why on my machines (no specific distro, just
> everything built from source and installed by me) login takes a long time,
> unless I have portmap running.
> 
> My /etc/nsswitch.conf would seem to be right:
> 
> What else could effect that?

check /etc/pam.d/login

Could be kerberos that is biting you, althrough that doesn't explain the
portmap story.



	Igmar


	

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
