Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163996AbWLGX0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163996AbWLGX0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163998AbWLGX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:26:32 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60250 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163996AbWLGX0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:26:31 -0500
Date: Fri, 8 Dec 2006 00:23:44 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
In-Reply-To: <45789D0F.6060100@oracle.com>
Message-ID: <Pine.LNX.4.61.0612080019490.27403@yvahk01.tjqt.qr>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
 <200612072254.51348.s0348365@sms.ed.ac.uk> <45789D0F.6060100@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7 2006 15:00, Randy Dunlap wrote:
>
>> > +but no space after unary operators:
>> > +		sizeof  ++  --  &  *  +  -  ~  !  defined
>> 
>> You could mention typeof too, which is a keyword but should be done like
>> sizeof.
>
> Hm, is that a gcc-ism?  It's not listed in the C99 spec.
>
> Are there other gcc-isms that I should add?

__attribute__(()) perhaps, which is often seen in kernel code.



   -fno-gnu-keywords
       Do not recognize "typeof" as a keyword, so that code can use this
       word as an identifier.  You can use the keyword "__typeof__"
       instead.  -ansi implies -fno-gnu-keywords.

Ergo it's a GNUism/GCCism. As long as <whatever> is used in kernel code, 
it should be documented.


	-`J'
-- 
