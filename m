Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbRGFWBp>; Fri, 6 Jul 2001 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266871AbRGFWBf>; Fri, 6 Jul 2001 18:01:35 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:44739 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266868AbRGFWBZ>; Fri, 6 Jul 2001 18:01:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Doug McNaught <doug@wireboard.com>
Subject: Re: The SUID bit (was Re: [PATCH] more SAK stuff)
Date: Fri, 6 Jul 2001 11:44:21 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107060145.f661j5v74941@saturn.cs.uml.edu> <01070606044004.00596@localhost.localdomain> <m3u20q6q9j.fsf@belphigor.mcnaught.org>
In-Reply-To: <m3u20q6q9j.fsf@belphigor.mcnaught.org>
MIME-Version: 1.0
Message-Id: <01070611442100.00640@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 11:17, Doug McNaught wrote:
> Rob Landley <landley@webofficenow.com> writes:
> > Do you have a code example of how a program with euid root can change its
> > actual uid (which several programs check when they should be checking
> > euid, versions of dhcpcd before I complained about it case in point)?
>
> Ummm...  setuid(2)?
>
> Works for me...

Albert Calahan cleared this up for me in email.  I thought that euid 0 
wouldn't let you actually setuid(0) for security reasons.  (Otherwise the 
distinction between the two of them seemed kind of pointless, which I must 
admit I'm now officially confused about, and likely to spend an evening with 
google over.)

Rob
