Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTKQJZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTKQJZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:25:44 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:18581 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S263415AbTKQJZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:25:42 -0500
Subject: Re: Measuring per thread CPU consumption & others statistics for
	NPTL
From: Peter Zaitsev <peter@mysql.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16312.5605.129233.279407@wombat.chubb.wattle.id.au>
References: <1068997909.2276.64.camel@abyss.local>
	 <16312.5605.129233.279407@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1069061123.2187.44.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 17 Nov 2003 12:25:27 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 03:27, Peter Chubb wrote:

> 
> Peter> Second question is about accuracy - Is any way to get
> Peter> system/user CPU consumption information with more than 1/100
> Peter> sec accuracy ?
> 
> If you apply my microstate accounting patch, you can get nanosecomnd
> resolution per thread.

Great Peter,

Is it planned to be included in the kernel at some point ?
For me it is the most important not to get things working on some
particular test systems, but to allow customers, which run generic or
vendor provided kernels to use the functionality.

Does your patch only computes statistics on per process basics or per
thread as well ?


-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

