Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUFTUHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUFTUHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFTUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:07:04 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:42125 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S265938AbUFTUHA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:07:00 -0400
Message-Id: <6.1.1.1.0.20040620135751.0e03fd50@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sun, 20 Jun 2004 14:06:57 -0600
To: David Woodhouse <dwmw2@infradead.org>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: [PATCH] Stop printk printing non-printable chars
Cc: matthew-lkml@newtoncomputing.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1087741064.28195.24.camel@localhost.localdomain>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
 <1087643904.5494.7.camel@imladris.demon.co.uk>
 <20040619154907.GE5286@newtoncomputing.co.uk>
 <1087741064.28195.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A LKML meta-patch:

@On Sat, 2004-06-19 at 16:49 +0100, matthew-lkml@newtoncomputing.co.uk wrote:
  Please forgive me if I'm wrong on this, but I seem to remember reading
  something a while ago indicating that the kernel is and always will be
-internally English (i.e. debugging messages and the like) as there is no
+internally that subset of English representable in 7-bit ASCII
+(i.e. debugging messages and the like) as there is no
  need to bloat it with many different languages (that can be done in
  userspace). As printk is really just a log system, I personally don't
  see any way that it should ever print anything other than ASCII.

P.S.  At 6/20/2004 03:17 PM +0100, David Woodhouse wrote:
>It's very naïve of you to think that English means nothing but ASCII.
>Non-ASCII characters play a very important rôle even in English
>communication.

Thank you for illustrating the point that maximizing portability and 
compatibility favors simplicity.
--
Jeff Woods <kazrak+kernel@cesmail.net> 


