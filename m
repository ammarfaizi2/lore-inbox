Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTDQXmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDQXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:42:48 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:7054 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262693AbTDQXmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:42:45 -0400
Date: Thu, 17 Apr 2003 19:50:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [BK+PATCH] remove __constant_memcpy
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304171954_MC3-1-34E7-5FFC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote: 


>> On x86, gcc doesn't have such an option, although "-mno-sse" and
>> "-mno-sse2" probably come closest (and we should probably use them, but
>> since older gcc's don't know about it and it hasn't been an issue yet we
>> haven't).
>
> gcc on x86 definitely wants a -fdontyoudareusefloatingpoint... The
> following snippet from the -msoft-float docs isn't encouraging:
>
>     On machines where a function returns floating point results in the
>     80387 register stack, some floating point opcodes may be emitted
>     even if `-msoft-float' is used.


  -mno-fp-ret-in-387 should fix that.



--
 Chuck
