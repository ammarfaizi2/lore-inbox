Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293252AbSCEBuU>; Mon, 4 Mar 2002 20:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293255AbSCEBuK>; Mon, 4 Mar 2002 20:50:10 -0500
Received: from zero.tech9.net ([209.61.188.187]:34323 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293252AbSCEBuC>;
	Mon, 4 Mar 2002 20:50:02 -0500
Subject: Re: [PATCH] Fast Userspace Mutexes III.
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 20:50:06 -0500
Message-Id: <1015293007.882.87.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:

> That's great. What if the process holding the mutex dies while there're
> sleeping tasks waiting for it ?

I can't find an answer in the code (meaning the lock is lost...) and no
one has yet answered.  Davide, have you noticed anything?

I think this needs a proper solution..

	Robert Love

