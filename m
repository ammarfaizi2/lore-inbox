Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSDYItM>; Thu, 25 Apr 2002 04:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312997AbSDYItL>; Thu, 25 Apr 2002 04:49:11 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:4115 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312996AbSDYItK>;
	Thu, 25 Apr 2002 04:49:10 -0400
Date: Thu, 25 Apr 2002 00:46:51 -0700
From: Greg KH <greg@kroah.com>
To: Alex Walker <alex@x3ja.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425074651.GA17368@kroah.com>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 28 Mar 2002 05:45:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 02:21:32PM +0100, Alex Walker wrote:
> Hi, I'm not subscribed - please CC me in any replies.
> 
> Two OOps when running 2.5.10, as attached. With attatched config.
> 
> First occurs on boot, but doesn't stop the whole system.  The second
> occurs as I was rebooting - see the attached log to see where they
> happen.
> 
> Any more info required?  Just ask.

Known problem with the uhci driver right now, just use usb-uhci instead
(not the ALT UHCI driver) for now until things get straightend out.

thanks,

greg k-h
