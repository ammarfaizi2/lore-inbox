Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUFQNdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUFQNdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUFQNdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:33:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:8460 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266488AbUFQNdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:33:46 -0400
Message-ID: <40D1A1CB.7090301@techsource.com>
Date: Thu, 17 Jun 2004 09:51:07 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jurriaan <thunder7@xs4all.nl>
CC: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] accelerated radeonfb produces artifacts on
 scrolling in 2.6.7
References: <20040616182415.GA8286@middle.of.nowhere> <20040616184145.GA12673@havoc.gtf.org> <40D0A5B4.7060007@techsource.com> <20040616195210.GA26935@middle.of.nowhere>
In-Reply-To: <20040616195210.GA26935@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jurriaan wrote:

>>Is this the case even with the off-by-one error in the bitblt code 
>>fixed?  In the 2.4 kernel, I got rid of all artifacts by fixing the 
>>off-by-one error.

> You mean this code? I see (w-1) and (h-1) in there.


> 
> 	if ( xdir < 0 ) { sx += w-1; dx += w-1; }
> 	if ( ydir < 0 ) { sy += h-1; dy += h-1; }


Yes, that's the code, and it's correct.

