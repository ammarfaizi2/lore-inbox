Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292461AbSBUPdn>; Thu, 21 Feb 2002 10:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292462AbSBUPdd>; Thu, 21 Feb 2002 10:33:33 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:1805 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292461AbSBUPdX>; Thu, 21 Feb 2002 10:33:23 -0500
Date: Thu, 21 Feb 2002 16:33:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: David Lang <david.lang@digitalinsight.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.44.0202210626210.8696-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.21.0202211626390.2705-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2002, David Lang wrote:

As Jeff already correctly said, I only have a converter that takes the
cml1 data and just outputs it into something different.

> 1. does this handle the cross directory dependancies?

The tool records all dependencies independent of the directory.

> 2. does it handle the 'I want this feature, turn on everything I need for
> it'?
> 
> 3. if it handles #2 what does it do if you turn off that feature again
> (CML2 turns off anything it turned on to support that feature, assuming
> nothing else needs it)

If you know the dependencies, it's not really difficult to implement this 
as far as it's possible.

bye, Roman

