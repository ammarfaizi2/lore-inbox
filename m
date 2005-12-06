Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVLFUHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVLFUHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVLFUHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:07:41 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27107 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932605AbVLFUHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:07:40 -0500
Subject: Re: Add tainting for proprietary helper modules.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051205093436.44d146e6@localhost.localdomain>
References: <20051203004102.GA2923@redhat.com>
	 <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
	 <20051205173041.GE12664@redhat.com>
	 <20051205093436.44d146e6@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 20:06:52 +0000
Message-Id: <1133899612.23610.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-05 at 09:34 -0800, Stephen Hemminger wrote:
> IMHO ndiswrapper can't claim legitimately to be GPL, so just
> patch that. 

Actually it isnt so simple. Load ndiswrapper. Now load a GPL windows
driver binary. I don't know if ndiswrapper itself could dig licenses out
of windows modules but if so it could even conditionally taint.

Alan

