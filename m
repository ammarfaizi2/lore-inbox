Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136537AbREIPVX>; Wed, 9 May 2001 11:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136540AbREIPVO>; Wed, 9 May 2001 11:21:14 -0400
Received: from ns-inetext.inet.com ([199.171.211.140]:41126 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S136537AbREIPVI>; Wed, 9 May 2001 11:21:08 -0400
Message-ID: <3AF96062.19528A86@inet.com>
Date: Wed, 09 May 2001 10:21:06 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: standard queue implementation?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I did a quick look in include/linux for a standard implementation of an
array-based circular queue, but I didn't see one.

I was thinking something that could be declared, allocated, and then
used with an addq and a removeq.  A deallocator would also be good.

Is there such a beast in the kernel?  If not, it seems that having
something like this would reduce the potential for bugs.

Thoughts?

Eli 
-----------------------.   No wonder we didn't get this right first time
Eli Carter             |      through. It's not really all that horribly 
eli.carter(at)inet.com `- complicated, but the _details_ kill you. Linus
