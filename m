Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUGAEE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUGAEE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUGAEE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:04:57 -0400
Received: from mail.shareable.org ([81.29.64.88]:48045 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263875AbUGAEEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:04:51 -0400
Date: Thu, 1 Jul 2004 05:04:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Table of mmap PROT_* implementations by architecture
Message-ID: <20040701040408.GD1564@mail.shareable.org>
References: <20040701033620.GB1564@mail.shareable.org> <0B128D6C-CB13-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B128D6C-CB13-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> >(1) - In kernel, maybe these pages are readable using "write()"?
> >      In each case that is labelled, I'm not sure from reading the code.
> >      (Pages are always readable using ptrace(), that's ok, but write()
> >      and other kernel reads shouldn't be able to read PROT_NONE pages).
>
> This is wrong for PPC32 and PPC64, see the email written earlier today:

Ah, bollocks!  I'd already updated the file from your earlier mail,
but didn't propagate that change to the email before sending it.

Thanks for pointing it out,
-- Jamie
