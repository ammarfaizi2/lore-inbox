Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317820AbSGKMTX>; Thu, 11 Jul 2002 08:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317821AbSGKMTW>; Thu, 11 Jul 2002 08:19:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35336 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317820AbSGKMTV>; Thu, 11 Jul 2002 08:19:21 -0400
Subject: Re: HZ, preferably as small as possible
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 11 Jul 2002 12:45:21 +0100 (BST)
Cc: andrew.grover@intel.com (Grover Andrew), cat@zip.com.au ('CaT'),
       bcrl@redhat.com (Benjamin LaHaise), akpm@zip.com.au (Andrew Morton),
       linux-kernel@vger.kernel.org (Linux)
In-Reply-To: <3D2CF4FB.5030600@mandrakesoft.com> from "Jeff Garzik" at Jul 10, 2002 11:01:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ScNt-0000iE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Grover, Andrew wrote:
> > So, a changing tick *can* be done. If Linux does the same thing, seems like
> > everyone is happy. What are the obstacles to this for Linux? If code is
> > based on the assumption of a constant timer tick, I humbly assert that the
> > code is broken.
> 
> I don't see that making 'HZ' a variable is really an option, because 
> many drivers and scheduler-related code will be wildly inaccurate as 
> soon as HZ actually changes values.

HZ never changes value. HZ is the top granularity we choose to operate at.
