Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUAVXMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUAVXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:12:09 -0500
Received: from dp.samba.org ([66.70.73.150]:24782 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266474AbUAVXMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:12:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Niraj Kumar <niraj17@iitbombay.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 : Kernel oops with rmmod 
In-reply-to: Your message of "Thu, 22 Jan 2004 17:08:53 +0530."
             <400FB64D.2050806@iitbombay.org> 
Date: Thu, 22 Jan 2004 23:34:32 +1100
Message-Id: <20040122231220.A54D72C07C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <400FB64D.2050806@iitbombay.org> you write:
> Hi ,
> I am getting kernel oops after rmmod .  I was doing some changes in ufs 
> filesystem
> (basically , trying to add support for ufs2) and then loaded/unloaded 
> the ufs module.
> Loading was fine. But rmmod crashed with "Segmentation fault" .

Most likely you introduced a bug.  Something you overran, or didn't
clean up?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
