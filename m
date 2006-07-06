Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWGFVM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWGFVM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWGFVM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:12:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750868AbWGFVM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:12:27 -0400
Date: Thu, 6 Jul 2006 14:12:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?J=2EA=2E_Magall=C3=B3n?= <jamagallon@ono.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060706230215.203c790c@werewolf.auna.net>
Message-ID: <Pine.LNX.4.64.0607061410390.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
 <Pine.LNX.4.64.0607061057240.12404@g5.osdl.org> <20060706230215.203c790c@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-245456896-1152220323=:3869"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-245456896-1152220323=:3869
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 6 Jul 2006, J.A. Magallón wrote:
> 
> I think you are mixing apples and oranges. Using volatile to control o-o-o
> memory accesses is sure wrong.

.. and there _is_ no right way to use it, except the two I've already 
mentioned. 

Why is that so hard to accept?

The fact is, "volatile" was designed in a different era, and tough, it's 
not one of the better parts of the C language.

Get over it.

			Linus
--21872808-245456896-1152220323=:3869--
