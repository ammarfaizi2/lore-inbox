Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSBGKEV>; Thu, 7 Feb 2002 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSBGKEL>; Thu, 7 Feb 2002 05:04:11 -0500
Received: from angband.namesys.com ([212.16.7.85]:39296 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S287048AbSBGKD5>; Thu, 7 Feb 2002 05:03:57 -0500
Date: Thu, 7 Feb 2002 13:03:56 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] oops with reiserfs and kernel 2.5.4-pre1 on sparc64
Message-ID: <20020207130356.A18577@namesys.com>
In-Reply-To: <20020207092012.C6351@namesys.com> <Pine.LNX.4.44.0202071058010.25208-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202071058010.25208-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 07, 2002 at 10:58:27AM +0100, Luigi Genoni wrote:

> > Can any of sparc64 people comment on what kind of exception will one
> > get for __builtin_trap?
> > Second BUG() seems to be out of the question, though.
> > Do you have CONFIG_DEBUG_BUGVERBOSE enabled?
> No, I have not
If you'd enable it, you'd get a message on a next crash, where this BUG()
happened exactly (so that we can verify my guess)

Bye,
    Oleg
