Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWGaUIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWGaUIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWGaUIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:08:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:2457 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932340AbWGaUIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:08:25 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: fix is_at_popf() for compat tasks
Date: Mon, 31 Jul 2006 22:06:55 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Albert Cahalan <acahalan@gmail.com>
References: <200607311302_MC3-1-C69F-F0D8@compuserve.com>
In-Reply-To: <200607311302_MC3-1-C69F-F0D8@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312206.55817.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> How about checking for regs->cs != __USER_CS instead?  In 64-bit mode
> a program shouldn't have any other value there while in 32-bit mode
> it could be using LDT segments.


It could in theory, but it shouldn't agreed.  Added thanks.
-Andi
