Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJ1QVs>; Mon, 28 Oct 2002 11:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSJ1QVs>; Mon, 28 Oct 2002 11:21:48 -0500
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:2263 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S261341AbSJ1QVs>; Mon, 28 Oct 2002 11:21:48 -0500
Date: Mon, 28 Oct 2002 16:28:19 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: Daniel Goujot <Daniel.Goujot@maths.univ-evry.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No rtl8139 found in menuconfig in linux-2.2.22
Message-ID: <20021028162819.GA9723@hobbes.itsari.int>
References: <Pine.LNX.4.33L2.0210281646450.14810-100000@grozny.maths.univ-evry.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33L2.0210281646450.14810-100000@grozny.maths.univ-evry.fr>; from Daniel.Goujot@maths.univ-evry.fr on Mon, Oct 28, 2002 at 16:00:29 +0000
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.02 16:00 Daniel Goujot wrote:

<snip snip>

> make menuconfig
> -- don't find the rtl8139 (I found the tulip network driver, not the
> rtl8139 network driver)


You need to say 'Y' in ->

   -- Code maturity level options
    -- Prompt for development and/or incomplete code/drivers

Then you'll have

    -- Network device support
     -- Ethernet (10 or 100Mbit)
      -- RealTek 8129/8139 (not 8019/8029!) support (NEW)
   
Hope this helps.


		Nuno
