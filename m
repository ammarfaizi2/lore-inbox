Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293016AbSBVV5r>; Fri, 22 Feb 2002 16:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293017AbSBVV5l>; Fri, 22 Feb 2002 16:57:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293016AbSBVV5X>;
	Fri, 22 Feb 2002 16:57:23 -0500
Message-ID: <3C76BEC1.5A13BCA1@mandrakesoft.com>
Date: Fri, 22 Feb 2002 16:57:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: endre@interware.hu
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Eepro100 driver.
In-Reply-To: <Pine.LNX.4.44.0202222133270.8602-100000@dusk.interware.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

endre@interware.hu wrote:
> 
> On Fri, 22 Feb 2002, Jeff Garzik wrote:
> 
> > > Would be a lot nicer to see someone spending the time pulling the
> > > useful bits out of e100 and putting it into eepro100. e100 is ugly and
> > > bloated for no reason.
> >
> > When it passes my review, it will not be.
> > e100 + my desired changes == eepro100 + my desired changes
> 
> Will it be possible to use the vlan code in the kernel with e100? From
> what I can see Intel has its own way of doing vlans and that seems
> powerful but overcomplicated to me.

If it's non-standard, it's not getting in the kernel.  We have VLAN
stuff already...

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
