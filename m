Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWFLCBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFLCBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 22:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFLCBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 22:01:23 -0400
Received: from smtp.enter.net ([216.193.128.24]:13318 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750765AbWFLCBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 22:01:22 -0400
From: Daniel Hazelton <dhazelton@enter.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Video drivers and System Management mode.
Date: Sun, 11 Jun 2006 22:01:20 -0400
User-Agent: KMail/1.7.2
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       linux-kernel@vger.kernel.org
References: <448C5BF0.7070601@superbug.demon.co.uk> <1150054232.14253.157.camel@mindpipe>
In-Reply-To: <1150054232.14253.157.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606112201.21027.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 June 2006 03:30 pm, Lee Revell wrote:
> On Sun, 2006-06-11 at 19:07 +0100, James Courtier-Dutton wrote:
> > Hi,
> >
> > I know we all laugh about the windows blue screen of death, but to be
> > fair, when Linux oops, it is not even able to display anything on the
> > screen, unless in dump terminal mode. I.e. Not X or some other GUI.
> >
> > Are there any plans to implement a sort of interactive system management
> > mode, that would pop up a window when Linux oops. Something like the
> > program called SoftICE for windows would be a nice addition to Linux,
> > and help with kernel development.
>
> kdb would definitely be a good starting point.  But I don't think it
> works if you're in X when the kernel crashes.
>

This problem is being addressed by the work several of us are doing on the 
kernel graphics system. Hopefully this will be addressed in the first major 
patch.

DRH
