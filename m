Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276631AbRJGTcC>; Sun, 7 Oct 2001 15:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJGTbm>; Sun, 7 Oct 2001 15:31:42 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:9742 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S276616AbRJGTbg>; Sun, 7 Oct 2001 15:31:36 -0400
Date: Sun, 7 Oct 2001 15:34:33 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Simon Kirby <sim@netnation.com>
Cc: Greg KH <greg@kroah.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
Message-ID: <20011007153433.G14479@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com> <20011007121851.A1137@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011007121851.A1137@netnation.com>; from sim@netnation.com on Sun, Oct 07, 2001 at 12:18:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001, Simon Kirby <sim@netnation.com> wrote:
> On Sun, Oct 07, 2001 at 11:49:46AM -0700, Linus Torvalds wrote:
> 
> > pre5:
> >  - Greg KH: USB update
> 
> This appears to break my Logitech optical mouse with uhci.  usb-uhci
> works fine.
> 
> hub.c: USB new device connect on bus1/2, assigned device number 2
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=2 (error=-110)

Could you give me the output of /proc/interrupts?

Do you see any other messages in dmesg?

What UHCI controller is this? (lspci -v)

JE

