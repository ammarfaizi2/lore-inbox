Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272030AbRHVPqC>; Wed, 22 Aug 2001 11:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272032AbRHVPpo>; Wed, 22 Aug 2001 11:45:44 -0400
Received: from codepoet.org ([166.70.14.212]:27227 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S272030AbRHVPpj>;
	Wed, 22 Aug 2001 11:45:39 -0400
Date: Wed, 22 Aug 2001 09:45:54 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
Message-ID: <20010822094554.A9760@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Rohland <cr@sap.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain> <m34rr12ueb.fsf@linux.local> <20010821114640.A25151@codepoet.org> <m3bsl81tm0.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3bsl81tm0.fsf@linux.local>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 22, 2001 at 08:44:39AM +0200, Christoph Rohland wrote:
> 
> BTW I appreciate the basics of the change for 2.4, but I don't agree
> that we should break cases which worked before. (And the comment in
> the sources is plain wrong that 2.2 failed in these cases)

But 2.2 _did_ fail.  If you take a linux 2.2.x system, add 4 Gigs
of swap, and then use sysinfo(), the sizes you get back are junk...  

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, andersen@lineo.com
--This message was written using 73% post-consumer electrons--
