Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbRF0Uxk>; Wed, 27 Jun 2001 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265399AbRF0Uxa>; Wed, 27 Jun 2001 16:53:30 -0400
Received: from mail.zmailer.org ([194.252.70.162]:52746 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S265398AbRF0UxQ>;
	Wed, 27 Jun 2001 16:53:16 -0400
Date: Wed, 27 Jun 2001 23:52:53 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Prasad Koya <kdp102@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BSD sockets with sys_socketcall
Message-ID: <20010627235253.H8897@mea-ext.zmailer.org>
In-Reply-To: <20010627192327.23875.qmail@web4001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627192327.23875.qmail@web4001.mail.yahoo.com>; from kdp102@yahoo.com on Wed, Jun 27, 2001 at 12:23:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 12:23:27PM -0700, Prasad Koya wrote:
> How does socket(), bind() and other BSD socket API
> calls in user applications are handled by system
> socketcall(). Does the compiler (say gcc) substitute
> socket() in user app with socketcall(SYS_SOCKET,..)?

   You are using libc wrappers which translate the BSD API
   to Linux kernel ABI.

> Thanks

/Matti Aarnio
