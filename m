Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUABBd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUABBd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:33:26 -0500
Received: from pD9526784.dip.t-dialin.net ([217.82.103.132]:53632 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S262153AbUABBdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:33:14 -0500
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
From: Andi Kleen <ak@muc.de>
Date: Fri, 02 Jan 2004 02:33:10 +0100
In-Reply-To: <19kgS-4HT-19@gated-at.bofh.it> (Paul Jackson's message of
 "Fri, 02 Jan 2004 00:20:14 +0100")
Message-ID: <m3pte3i17t.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <19ahq-7Rg-11@gated-at.bofh.it> <19eEs-5lC-15@gated-at.bofh.it>
	<19kgS-4HT-19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on

That was a bug in gcc 3.3.0. It had the -Wsign-compare warning 
enabled in -Wall by mistake. Update to gcc 3.3.1, which has this fixed.

-Andi
