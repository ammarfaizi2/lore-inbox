Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSDYSEI>; Thu, 25 Apr 2002 14:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSDYSEH>; Thu, 25 Apr 2002 14:04:07 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:2829 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S313254AbSDYSEH>; Thu, 25 Apr 2002 14:04:07 -0400
Date: Thu, 25 Apr 2002 14:04:07 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: Alex Walker <alex@x3ja.co.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425140407.A21887@sventech.com>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk> <20020425074651.GA17368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002, Greg KH <greg@kroah.com> wrote:
> On Wed, Apr 24, 2002 at 02:21:32PM +0100, Alex Walker wrote:
> > Hi, I'm not subscribed - please CC me in any replies.
> > 
> > Two OOps when running 2.5.10, as attached. With attatched config.
> > 
> > First occurs on boot, but doesn't stop the whole system.  The second
> > occurs as I was rebooting - see the attached log to see where they
> > happen.
> > 
> > Any more info required?  Just ask.
> 
> Known problem with the uhci driver right now, just use usb-uhci instead
> (not the ALT UHCI driver) for now until things get straightend out.

Just to clarify, it's a known problem with the USB core that uhci
happens to trigger.

I'm working on an approriate patch.

JE

