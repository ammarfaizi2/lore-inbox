Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJMIt0>; Sun, 13 Oct 2002 04:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261465AbSJMIt0>; Sun, 13 Oct 2002 04:49:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25229 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261464AbSJMItZ>;
	Sun, 13 Oct 2002 04:49:25 -0400
Date: Sun, 13 Oct 2002 01:48:24 -0700 (PDT)
Message-Id: <20021013.014824.35797032.davem@redhat.com>
To: efault@gmx.de
Cc: wagnerjd@prodigy.net, robm@fastmail.fm, hahn@physics.mcmaster.ca,
       linux-kernel@vger.kernel.org, jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20021013104231.00bbbf88@pop.gmx.net>
References: <20021013.011344.58438240.davem@redhat.com>
	<000f01c27294$438d5fa0$7443f4d1@joe>
	<5.1.0.14.2.20021013104231.00bbbf88@pop.gmx.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mike Galbraith <efault@gmx.de>
   Date: Sun, 13 Oct 2002 10:48:21 +0200
   
   You seem to think "threaded" means there can be no critical sections.

And as I mention in my other email, the allocation can be
broken down into a single instruction's worth of critical section.
Which is as good as his version of "threaded" could be.
