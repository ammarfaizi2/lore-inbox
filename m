Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUAVXaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAVXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:30:21 -0500
Received: from are.twiddle.net ([64.81.246.98]:24216 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264963AbUAVXaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:30:19 -0500
Date: Thu, 22 Jan 2004 15:30:16 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Valdis.Kletnieks@vt.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
Message-ID: <20040122233016.GA21967@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Valdis.Kletnieks@vt.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401212043200.2123@home.osdl.org> <20040122060253.GA18719@twiddle.net> <Pine.LNX.4.58.0401220725180.2123@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401220725180.2123@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 07:27:52AM -0800, Linus Torvalds wrote:
> Shorthand or not, the "+m" usage is (a) totally logical

Logical or not, "+" is not how reload works; this must be split to use "0".

> and (b) historically allowed.

Allowed (since 2.8 or so), but it didn't always work.  The nth bug report
is what prompted the addition of the warning.

> Please fix the compiler.

Maybe someday, but not I'm not rewriting reload today.  Given there *is*
an alternative way to write this, it is definitely not a priority.


r~
