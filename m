Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUAWAZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUAWAZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:25:58 -0500
Received: from are.twiddle.net ([64.81.246.98]:28056 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266484AbUAWAZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:25:57 -0500
Date: Thu, 22 Jan 2004 16:25:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Valdis.Kletnieks@vt.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
Message-ID: <20040123002555.GA22136@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Valdis.Kletnieks@vt.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401212043200.2123@home.osdl.org> <20040122060253.GA18719@twiddle.net> <Pine.LNX.4.58.0401220725180.2123@home.osdl.org> <20040122233016.GA21967@twiddle.net> <Pine.LNX.4.58.0401221538030.2998@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401221538030.2998@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:39:44PM -0800, Linus Torvalds wrote:
> > Logical or not, "+" is not how reload works; this must be split to use "0".
> 
> Why don't you split it to do "m" instead?

Um, duh.  That I can do.

> So why break it?

We didn't break anything, or even change the code involved.
Just added a warning.



r~
