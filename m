Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbTC0EGs>; Wed, 26 Mar 2003 23:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbTC0EGs>; Wed, 26 Mar 2003 23:06:48 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:42756 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262810AbTC0EGr>; Wed, 26 Mar 2003 23:06:47 -0500
Date: Thu, 27 Mar 2003 04:17:59 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Module load notification take 3
Message-ID: <20030327041759.GA4367@compsoc.man.ac.uk>
References: <20030325114152.GB30581@compsoc.man.ac.uk> <20030327041148.0A4A12C054@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327041148.0A4A12C054@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18yOpz-000Hhc-00*NtzKQgAp4mA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 01:20:23PM +1100, Rusty Russell wrote:

> What reason?  I just grepped 2.5.66-bk2, and *noone* uses the return
> value, not even to BUG() (you have to grep for all the wrappers for
> notifier_call_unregister, too).

Just more grist for the mill of the ill ...

> (I assume you mean notifier_call_unregister).  Yes, but that's another
> battle.

... and it's the same ill. Half-cleaned up stuff sucks. Either remove it
or don't.

> That's because everyone realizes that the return value is useless.

It detects one variant of unmatched register/unregister, so it cannot be
said to be entirely useless. I would not call it entirely useful,
though, I admit.

Beside the point though really, I appear to have made onto Linus'
shitlist at last ... does this mean I finally graduated Linux School ?

regards
john
