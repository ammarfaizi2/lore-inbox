Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUISUB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUISUB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUISUB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:01:27 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:33239 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263024AbUISUB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:01:26 -0400
Message-ID: <35fb2e59040919130154966337@mail.gmail.com>
Date: Sun, 19 Sep 2004 21:01:22 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Sergei Haller <sergei.haller@math.uni-giessen.de>
Subject: Re: lost memory on a 4GB amd64
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
	 <200409161528.19409.andrew@walrond.org>
	 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
	 <200409161619.28742.andrew@walrond.org>
	 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de>
	 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 00:18:38 +1000 (EST), Sergei Haller 

> * if the memory configuration is as follows: the first 3gb ar at the
>   normal address range, the fourth gb is at the address range 4-5gb.
>   then all 4gb are available (not quite -- a few mb ere missing, but
>   thats ok) and
>    - the SMP kernel panics as soon as I start X

Just out of interest - can you say what tests you ran here - for
example whether you tried allocating large amounts of memory from a
userspace process without running X and/or touching bits of memory
mapped hardware? You say a kernel compile works fine so can you rule
out this being X taking down the system (you're previous mail seemed
somehat unclear).

Jon.
