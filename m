Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTIBSjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbTIBSjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:39:02 -0400
Received: from [62.241.33.80] ([62.241.33.80]:49159 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261403AbTIBSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:39:00 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22aa1
Date: Tue, 2 Sep 2003 20:38:39 +0200
User-Agent: KMail/1.5.3
References: <20030902020218.GB1599@dualathlon.random>
In-Reply-To: <20030902020218.GB1599@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309022037.39364.m.c.p@wolk-project.de>
Cc: Kurt Garloff <garloff@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 September 2003 04:02, Andrea Arcangeli wrote:

Hi Andrea,

> Only in 2.4.22aa1: 20_sched-o1-fixes-10
> Only in 2.4.22pre7aa1: 20_sched-o1-fixes-9
> 	Changed the CHILD_PENALTY logic to be centered around
> 	50%. From Kurt Garloff.

the changes 's/CHILD_PENALTY/CHILD_INHERITANCE' and "s/PARENT_PENALTIY//' are 
really awfull for desktops. If I change child_inheritance from 60 to 95 and 
reintroduce the logic with parent_penaltiy, it's alot smooter under load.

I think these logics should be #ifdef'ed with CONFIG_DESKTOP, no?

ciao, Marc

