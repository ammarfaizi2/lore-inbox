Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUIQWeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUIQWeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269231AbUIQWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:34:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:12221 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269101AbUIQWbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:31:41 -0400
Date: Sat, 18 Sep 2004 00:23:42 +0200 (MEST)
Message-Id: <200409172223.i8HMNgNu004437@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: damouse@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: FASTCALL fixing?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 18:38:46 +0100, DaMouse <damouse@gmail.com> wrote:
>       I get errors about the fastcall and type conflicts in 2.4.27
>(yeah its old.. i know :) ) I was wondering what the politically
>correct way of fixing these are? adding fastcall type to
>kernel/sched.c or removing FASTCALL() around it in sched.h?

gcc-3.4? Known issue. Fixed in 2.4.28-pre ages ago,
as the LKML archives should have told you.
