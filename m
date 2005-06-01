Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFAOyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFAOyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVFAOyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:54:35 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:48318 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261403AbVFAOyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:54:31 -0400
Message-ID: <429DCE15.76545CBD@tv-sign.ru>
Date: Wed, 01 Jun 2005 19:02:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <Pine.LNX.4.44.0506010741060.23057-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> On Wed, 1 Jun 2005, Oleg Nesterov wrote:
> 
> > fifo? 2
> > fifo? 1
> > fifo? 0
> 
> plist_for_each() wasn't designed to be FIFO , as you've discovered. That's
> the slow method , you should test the fast method via pulling the nodes
> off the front of the list.

Sorry, I don't understand you. Could you please explain this to me?

Oleg.
