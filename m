Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWCUPF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWCUPF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWCUPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:05:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39617 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751761AbWCUPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:05:26 -0500
Subject: Re: help with SMP debugging...task struct corruption
From: Arjan van de Ven <arjan@infradead.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44201325.2010008@nortel.com>
References: <44201325.2010008@nortel.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 16:05:22 +0100
Message-Id: <1142953522.3077.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 08:52 -0600, Christopher Friesen wrote:
> I'm running a customized 2.6.10 and seeing some interesting behaviour. 
> Based on some additional debugging that we added, the "p->signal" member 
> is being set to NULL between the time we call spin_lock() and the time 
> we return from it.

hmm odd... is your kernel patch available somewhere? Maybe there's a bug
in that (since this is not normal behavior at all)
(but then again 2.6.10 is *old* :)

