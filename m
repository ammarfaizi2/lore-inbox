Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVFLE4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVFLE4D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVFLE4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:56:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47862 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261907AbVFLEzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:55:33 -0400
Date: Sat, 11 Jun 2005 21:55:18 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42ABC089.8080100@opersys.com>
Message-ID: <Pine.LNX.4.44.0506112151090.24837-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Karim Yaghmour wrote:
 
 
> This is why I have a hard time understanding the statement that
> "It would be Linux and Adeos, but never just Linux." In this case,
> it would be Linux with an ipipe. Said ipipe can then be left
> unpopulated, and then we get back to what you guys have just
> implemented. Or a driver can use it to obtain hard-rt. Or
> additional Adeos components can hook onto the ipipe to provide
> services enabling RTAI to run side-by-side with Linux.

My reasoning is that Linux doesn't run in ring 0 . That to me makes linux 
and ADEOS two different entities. That's my way of looking at it. 

> May I suggest getting a copy of a recent Adeos patch and looking
> through it? I'm sure it would make things much simpler to
> understand.

I haven't looked at the code, I would like to . I have read about 
the ADEOS implementation .

Daniel

