Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUHaRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUHaRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUHaRj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:39:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:59784 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265697AbUHaRjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:39:22 -0400
Subject: Re: PATCH: Root reservations for strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ch2b68$985$1@gatekeeper.tmr.com>
References: <20040831143449.GA26680@devserv.devel.redhat.com>
	 <ch2b68$985$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093970232.611.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 17:37:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 18:13, Bill Davidsen wrote:
> Would it be a problem to put a lower bound on how much to leave for 
> root? If it's really too small to be useful, perhaps one of (a) reserve 
> enough to be useful or (b) don't bother to reserve at all, should be 

Possibly. I'm currently following what someone appears to have decided
is correct behaviour. It probably should be tunable

