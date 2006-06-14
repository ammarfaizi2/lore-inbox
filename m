Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWFNUxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWFNUxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 16:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFNUxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 16:53:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31439 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932292AbWFNUxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 16:53:04 -0400
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
From: Sridhar Samudrala <sri@us.ibm.com>
To: Daniel Phillips <phillips@google.com>, davem@davemloft.net
Cc: Harald Welte <laforge@gnumonks.org>, bidulock@openss7.org,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44904C08.6020307@google.com>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
	 <20060613140716.6af45bec@localhost.localdomain>
	 <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com>
	 <20060614133022.GU11863@sunbeam.de.gnumonks.org>
	 <44904C08.6020307@google.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 13:52:16 -0700
Message-Id: <1150318336.20846.22.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 10:48 -0700, Daniel Phillips wrote:

> 
> Did we settle the question of whether these particular exports should be
> EXPORT_SYMBOL_GPL?

When i submitted this patch, i didn't really think about the different
ways to export these symbols. I simply used the EXPORT_SYMBOL() that is 
used by all the other exports in net/socket.c including kernel_sendmsg()
and kernel_recvmsg().

I am OK with either option(EXPORT_SYMBOL or EXPORT_SYMBOL_GPL) and i will
leave it to David Miller to make that decision at this point.

Thanks
Sridhar

