Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSILJpa>; Thu, 12 Sep 2002 05:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSILJpa>; Thu, 12 Sep 2002 05:45:30 -0400
Received: from ns.suse.de ([213.95.15.193]:39438 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315214AbSILJpa>;
	Thu, 12 Sep 2002 05:45:30 -0400
To: Allan Duncan <allan.d@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and agpgart
References: <3D7FF444.87980B8E@bigpond.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Sep 2002 11:50:19 +0200
In-Reply-To: Allan Duncan's message of "12 Sep 2002 03:58:45 +0200"
Message-ID: <p73ptvjpmec.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan <allan.d@bigpond.com> writes:
> 
> Any suggestions of how to improve the error messages around the failure point
> are welcome.  Nothing is written into dmesg at the time of failure.

You're booting with mem=nopentium right ? It should go away when you turn
that off. I'm working on a fix. You can safely turn it off for now, the 
old problems that it worked around are fixed.

-Andi
