Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVEZVQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVEZVQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVEZVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:14:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42226 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261791AbVEZVOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:14:08 -0400
Subject: Re: RT patch acceptance
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050526205227.GA3776@nietzsche.lynx.com>
References: <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>  <20050526205227.GA3776@nietzsche.lynx.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:14:02 -0700
Message-Id: <1117142042.1583.77.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 13:52 -0700, Bill Huey wrote:

Sorry for the empty reply. 

I was putting a hotdog under the saw to see if it would stop.

> > If you drop irq threads then you cannot convert all locks
> > anymore or have to add ugly in_interrupt()checks. So any conversion like
> > that requires converting locks.
> 
> That's reversed. Interrupt threads are an isolated change itself and can
> be submitted upstream if so desired with no associated lock changes.



Precisely what was stated in the first place.

> bill
> 

