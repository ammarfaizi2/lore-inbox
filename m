Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSFVO4q>; Sat, 22 Jun 2002 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSFVO4p>; Sat, 22 Jun 2002 10:56:45 -0400
Received: from holomorphy.com ([66.224.33.161]:48325 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313202AbSFVO4p>;
	Sat, 22 Jun 2002 10:56:45 -0400
Date: Sat, 22 Jun 2002 07:56:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] floppy requests
Message-ID: <20020622145614.GG22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200206221033.MAA15741@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200206221033.MAA15741@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2002 16:04:17 -0700, William Lee Irwin III wrote:
>> generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
>> Unable to handle kernel NULL pointer dereference at virtual address 000000a0

On Sat, Jun 22, 2002 at 12:33:57PM +0200, Mikael Pettersson wrote:
> Search the LKML archives, keyword floppy.
> Floppies work in raw mode with a patch, but FS access to mounted
> floppies will hang your kernel or destroy data.

I've no idea why grub wants to get at a floppy, I'm trying to get
at /dev/sdk and there are literally no floppy drives or controllers
in the system.


Cheers,
Bill
