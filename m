Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbTHVAvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTHVAvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:51:20 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:29860 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262969AbTHVAvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:51:09 -0400
Message-ID: <3F4568D2.5080705@nortelnetworks.com>
Date: Thu, 21 Aug 2003 20:50:26 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: rob@landley.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jamie Lokier <jamie@shareable.org>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <lRjc.6o4.3@gated-at.bofh.it> <20030820234810.GA24970@mail.jlokier.co.uk> <3F440C15.1050301@pobox.com> <200308212032.25334.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 20 August 2003 20:02, Jeff Garzik wrote:

>>>If userspace applications are ultimately compiled using Linux header
>>>files, indirectly included via Glibc or some other libc, and the
>>>kernel header files are GPL (version 2 only; not LGPL or any later
>>>GPL), isn't distributing those binary applications a gross violation
>>>of the GPL in some cases?

>>One way or another (direct inclusion, or via glibc-kernheaders pkg) the
>>headers today are GPL'd not LGPL'd... so I suppose it remains the realm
>>of lawyers...

> So I take it one of the goals of cleaned and pressed kernel-ABI headers for 
> 2.7 would be to have them distributable under LGPL?  (Just trying to be 
> explicit, here...)


I thought that this case (including kernel headers) was the whole point 
of the exemption in the COPYING file.  Am I missing something?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

