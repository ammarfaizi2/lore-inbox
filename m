Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSHaTCU>; Sat, 31 Aug 2002 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHaTCU>; Sat, 31 Aug 2002 15:02:20 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:6415 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S317865AbSHaTCU>;
	Sat, 31 Aug 2002 15:02:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
References: <15727.64653.78081.277222@charged.uio.no>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 31 Aug 2002 21:06:48 +0200
In-Reply-To: <15727.64653.78081.277222@charged.uio.no> (Trond Myklebust's
 message of "Sat, 31 Aug 2002 01:30:06 +0200")
Message-ID: <87wuq6zw3b.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> Introduce basic *BSD style user credentials of the form
>
> struct ucred {
>        atomic_t	count;
>        uid_t	uid;
>        gid_t	gid;
>        int	ngroups;
>        gid_t	*groups;
> };
>
> and replace fsuid, fsgid, ngroups, groups in the struct task.

What about the fs member in struct task?
