Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWAMNAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWAMNAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWAMNAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:00:05 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:56779 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422652AbWAMNAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:00:02 -0500
From: Duncan Sands <baldrick@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/62] sem2mutex: -V1
Date: Fri, 13 Jan 2006 13:59:59 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20060113124402.GA7351@elte.hu>
In-Reply-To: <20060113124402.GA7351@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131400.00279.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch-queue converts 66% of all semaphore users in 2.6.15-git9 to 
> mutexes.

Hi Ingo, the changes to drivers/usb/atm/usbatm.[ch] conflict with a bunch
of patches I just sent to Greg KH.  How do you plan to handle this kind of
thing?  If you like, I can tweak this part of your patch so it applies on
top of mine, and push it to Greg.

Best wishes,

Duncan.
