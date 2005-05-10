Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVEJTpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEJTpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVEJTpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:45:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18430 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261757AbVEJTo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:44:28 -0400
Subject: RE: [PATCH 2/4] rt_mutex: add new plist implementation
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1115754260.14326.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2005 12:44:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 11:39, Perez-Gonzalez, Inaky wrote:

> 
> I guess I am still very biased by my implementation, where returning
> that was almost free because of how the functions where implemented
> (which steamed from the fact that they had to always compute the
> new priority to store it in the head).
> 
> So as you say, the best way is wrapping your primitives around. I'd
> suggest a shorter postfix, something like _prio() or _chkprio().

I still say re-implementation of plist is a waste .. Why re-make the
wheel when you have a perfectly good starting point .

Daniel

