Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVDBSQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDBSQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDBSQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:16:06 -0500
Received: from wing.tritech.co.jp ([202.33.12.153]:22915 "HELO
	wing.tritech.co.jp") by vger.kernel.org with SMTP id S261162AbVDBSPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:15:43 -0500
Date: Sun, 03 Apr 2005 03:15:42 +0900 (JST)
Message-Id: <20050403.031542.23015132.ooyama@tritech.co.jp>
To: cw@f00f.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack size
From: ooyama eiichi <ooyama@tritech.co.jp>
In-Reply-To: <20050402175345.GA28710@taniwha.stupidest.org>
References: <20050403.024634.88477140.ooyama@tritech.co.jp>
	<20050402175345.GA28710@taniwha.stupidest.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

> On Sun, Apr 03, 2005 at 02:46:34AM +0900, ooyama eiichi wrote:
> 
> > How can I know the rest size of the kernel stack.
> 
> you can't in a platfork-independant way

in i386 and ia64.

> 
> > (in my kernel driver)
> 
> *why* do you want to do this?
> 

because my driver hungs the machine by an certain ioctl.
and it seems to me there is no bad in the code correspond to 
the ioctl, except for that it is using large auto variables.
(some functions are useing ~1KB autos)

