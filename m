Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTCFNkf>; Thu, 6 Mar 2003 08:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTCFNke>; Thu, 6 Mar 2003 08:40:34 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:42442 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S268089AbTCFNke>; Thu, 6 Mar 2003 08:40:34 -0500
Date: Fri, 7 Mar 2003 00:47:46 +1100
From: CaT <cat@zip.com.au>
To: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - xircom realport no workie well
Message-ID: <20030306134746.GE464@zip.com.au>
References: <20030306130340.GA453@zip.com.au> <20030306132904.A838@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306132904.A838@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 01:29:04PM +0000, Russell King wrote:
> Can you check whether the attached patch fixes this for you?  It's more

Started compiling it and it just bombed out:

drivers/serial/8250_pci.c:1920: `PCI_DEVICE_ID_XIRCOM_RBM56G' undeclared
here (not in a function)
drivers/serial/8250_pci.c:1920: initializer element is not constant
drivers/serial/8250_pci.c:1920: (near initialization for
`serial_pci_tbl[86].device')

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

