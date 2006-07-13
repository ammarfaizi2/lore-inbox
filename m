Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWGMHPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWGMHPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWGMHPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:15:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10668 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751492AbWGMHPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:15:03 -0400
Subject: Re: Very long startup time for a new thread
From: Arjan van de Ven <arjan@infradead.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030B55B0@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030B55B0@exmail1.se.axis.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:14:55 +0200
Message-Id: <1152774895.3024.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 08:07 +0200, Mikael Starvik wrote:
> (This is on a 200 MIPS embedded architecture).
> 
> On a heavily loaded system (loadavg ~4) I create a new pthread. In this
> situation it takes ~4 seconds (!) before the thread is first scheduled in
> (yes, I have debug outputs in the scheduler to check that). In a 2.4 based
> system I don't see the same thing. I don't have any RT or FIFO tasks. Any
> ideas why it takes so long time and what I can do about it?

I assume you're using a new enough glibc that supports NPTL ?


