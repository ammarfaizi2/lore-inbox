Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbTCMQiV>; Thu, 13 Mar 2003 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbTCMQiU>; Thu, 13 Mar 2003 11:38:20 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:53924 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262474AbTCMQiT>; Thu, 13 Mar 2003 11:38:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Thu, 13 Mar 2003 17:53:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303130103.h2D13ESc001101@eeyore.valparaiso.cl>
In-Reply-To: <200303130103.h2D13ESc001101@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030313164905.9E1A6107776@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Mar 03 02:03, Horst von Brand wrote:
> Daniel Phillips <phillips@arcor.de> said:
>
> [...]
>
> > For dependencies between changes, rather than any fixed ordering, it's
> > better to record the actual precedence information, i.e., "a before b",
> > where a and b are id numbers of changes (I think everybody agrees changes
> > are first class objects).  These precedence relations can be determined
> > automatically: if two changes do not occur in the same file, there is no
> > certainly no precedence relation.
>
> Wrong. Edit a header adding a new type T. Later change an existing file
> that already includes said header to use T. Change a function, fix most
> uses. Find a wrong usage later and fix it separately. Change something, fix
> its Documentation/ later. Note how you can come up with dependent changes
> that _can't_ be detected automatically.

You confused semantic dependencies with structural dependencies that
govern whether or not deltas conflict in the reject sense.  Detailed reply is 
off-list.

Regards,

Daniel
