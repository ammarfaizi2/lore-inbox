Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUCMTsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUCMTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:48:53 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:58059 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263182AbUCMTsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:48:51 -0500
Subject: Re: i386 very early memory detection cleanup patch breaks the build
From: James Bottomley <James.Bottomley@steeleye.com>
To: hpa@zytor.com
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079198139.2512.19.camel@mulgrave>
References: <1079198139.2512.19.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 14:48:02 -0500
Message-Id: <1079207284.1759.28.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 12:15, James Bottomley wrote:
> P.S.  I'm still compiling, I'll yell again if the patch breaks at
> runtime too.

OK, I confirm a total boot time failure as well.  It looks like the CPUs
are unable to map their CPI memory.

Reversing the patch entirely fixes the problem.

I'll dig around and see if I can uncover the reason.

James

