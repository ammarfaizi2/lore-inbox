Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUH1UhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUH1UhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUH1UgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:36:17 -0400
Received: from the-village.bc.nu ([81.2.110.252]:6272 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267998AbUH1URm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:42 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412AC08E.nailBG411JOFC@burner>
References: <412AC08E.nailBG411JOFC@burner>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093353308.2810.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-24 at 05:14, Joerg Schilling wrote:
> Dou you know of any other system where you can say:
> 
> 	Print me a strack trace with symbols for all processes on this
> 	computer (even stripped ones) that call gettimeofday() within the
> 	next few seconds.
> 
> Note that you do not need a special kernel, no reboot, no restart of 
> applications.

Linux, BSD since 1990 or so.... For that matter I can do the same for
dynamically linked applications at library level. The difference is that
I don't have a happy point-and-click UI for it I have to go write a
little bit of code and the efficiency level. The SuSE proposed patch for
syscall restriction conveniently offers a way to remove the overhead.


