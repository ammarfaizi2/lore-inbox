Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272040AbRHVQFD>; Wed, 22 Aug 2001 12:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272043AbRHVQEx>; Wed, 22 Aug 2001 12:04:53 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:30864 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S272040AbRHVQEn>; Wed, 22 Aug 2001 12:04:43 -0400
From: Christoph Rohland <cr@sap.com>
To: andersen@codepoet.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain>
	<m34rr12ueb.fsf@linux.local> <20010821114640.A25151@codepoet.org>
	<m3bsl81tm0.fsf@linux.local> <20010822094554.A9760@codepoet.org>
Organisation: SAP LinuxLab
Date: 22 Aug 2001 18:04:37 +0200
In-Reply-To: <20010822094554.A9760@codepoet.org>
Message-ID: <m3hev0w06i.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

On Wed, 22 Aug 2001, Erik Andersen wrote:
> On Wed Aug 22, 2001 at 08:44:39AM +0200, Christoph Rohland wrote:
>> 
>> BTW I appreciate the basics of the change for 2.4, but I don't
>> agree that we should break cases which worked before. (And the
>> comment in the sources is plain wrong that 2.2 failed in these
>> cases)
> 
> But 2.2 _did_ fail.  If you take a linux 2.2.x system, add 4 Gigs of
> swap, and then use sysinfo(), the sizes you get back are junk...

But if you add 3.9GB it is ok. Also with 3.9GB RAM. And that's a quite
common machine in our environment.

If one of these overflows I agree that the 2.4 scheme is better. But
we should keep compatibility as long as we have no single field which
overflows.

And that's what my patch implements.

Greetings
		Christoph


