Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWDMUYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWDMUYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWDMUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:24:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5854
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964962AbWDMUYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:24:03 -0400
Date: Thu, 13 Apr 2006 13:23:35 -0700 (PDT)
Message-Id: <20060413.132335.77438118.davem@davemloft.net>
To: mbligh@mbligh.org
Cc: kplkml@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <443E74C1.5090801@mbligh.org>
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
	<443E74C1.5090801@mbligh.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@mbligh.org>
Date: Thu, 13 Apr 2006 08:56:49 -0700

> SpecJBB is a really frigging stupid benchmark. It's *much* more affected
> by the stupid crap in Java (like their locking model) than anything in the
> OS. 
> 
> Best to find another benchmark, oh and preferably somebody vaguely
> objective to run it ;-)

This may be true, but on a more serious note someone should check
to make sure Sun turned on hugepage support in the JVM under Linux.

That is one thing that helps this benchmark out enormously, so if
hugepages are disabled you might as well ignore the result.
