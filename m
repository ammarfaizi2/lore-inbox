Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUEaMIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUEaMIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUEaMIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 08:08:43 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28165 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264371AbUEaMIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 08:08:41 -0400
Subject: Re: 2.6.7-rc1, 3com still broken after resume
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       David Ford <david+challenge-response@blue-labs.org>
In-Reply-To: <200405310759.10963.linux-kernel@borntraeger.net>
References: <40BAB8D9.2080705@blue-labs.org>
	 <200405310759.10963.linux-kernel@borntraeger.net>
Content-Type: text/plain
Message-Id: <1086005305.1681.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Mon, 31 May 2004 14:08:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-31 at 07:59, Christian Borntraeger wrote:
> David Ford wrote:
> > May 30 21:37:39 powerix PM: Preparing system for suspend
> [error messages]
> 
> Which 3com driver fails? 3c59x?
> 
> Have you checked this patch?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108591456410688&w=2
> 
> If it helps, you should report back.

It doesn't work for me... When resuming from disk (swsusp), I have to
manually eject my 3c59x CardBus NIC and then plug it in.

