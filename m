Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDQFc2>; Tue, 17 Apr 2001 01:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDQFcS>; Tue, 17 Apr 2001 01:32:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23135 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132552AbRDQFcJ>; Tue, 17 Apr 2001 01:32:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        dwguest@win.tue.nl (Guest section DW), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
In-Reply-To: <E14pIo2-0001G8-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2001 23:30:29 -0600
In-Reply-To: Alan Cox's message of "Tue, 17 Apr 2001 00:53:15 +0100 (BST)"
Message-ID: <m1zodgrt3e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Yes, but they could be. Changing the Linux keycodes is a major
> > break with compatibility. If the Linux keycodes are to be changed,
> > then they ought to be become something that would allow XFree86
> > to become keyboard-independent. Why invent yet another encoding?
> 
> You dont need to break compatibility. We have cooked, raw, semi-raw type modes
> for keyboard right now. We just need to add semi-raw-extended and raw-extended

Of course don't have raw via terminal escape string, which can be a royal pain
on a remote machine, if you know how to use the raw keycodes.  

Eric


