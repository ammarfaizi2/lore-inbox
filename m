Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVANBhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVANBhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVANBdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:33:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:21700 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261751AbVANBaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:30:55 -0500
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lcall disappeared? kernel CVS destabilized?
References: <20050114010132.GJ5949@dualathlon.random>
From: Andi Kleen <ak@muc.de>
Date: Fri, 14 Jan 2005 02:30:54 +0100
In-Reply-To: <20050114010132.GJ5949@dualathlon.random> (Andrea Arcangeli's
 message of "Fri, 14 Jan 2005 02:01:32 +0100")
Message-ID: <m1llawajap.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@cpushare.com> writes:

> I'm porting the seccomp patch to 2.6.10, do you have an idea where lcall
> (i.e. call gates for binary compatibility with other OS) went? I can't
> find it anywhere. Looks like it was dropped but I must be sure of that,
> and especially I must be sure that you don't add it again without me
> noticing that I had to patch it ;). Is lcall definitely dead code that I
> can forget about or am I missing something? Thanks.

hch removed it some time ago because nobody used it anymore (Linux ABI
is not supported on 2.6) and it showed some potential security issues 

-Andi
