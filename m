Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSGRBDX>; Wed, 17 Jul 2002 21:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSGRBDX>; Wed, 17 Jul 2002 21:03:23 -0400
Received: from holomorphy.com ([66.224.33.161]:52104 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317354AbSGRBDX>;
	Wed, 17 Jul 2002 21:03:23 -0400
Date: Wed, 17 Jul 2002 18:06:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718010617.GL1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 04:55:38PM +0100, Matthew Wilcox wrote:
> On a headless box with both CONFIG_VT_CONSOLE and CONFIG_SERIAL_CONSOLE
> defined, I get:
> Freeing unused kernel memory: 452k freed
> visual_init: sw = 00000000, conswitchp = 00000000, currcons = 0, init = 1
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c01b775f
> *pde = 37868001
> *pte = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01b775f>]    Not tainted
> EFLAGS: 00010286

Could you reproduce this and get maybe a backtrace and a line number?


Thanks,
Bill
