Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSLFRlI>; Fri, 6 Dec 2002 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSLFRlI>; Fri, 6 Dec 2002 12:41:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:14222 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264908AbSLFRlI>; Fri, 6 Dec 2002 12:41:08 -0500
Date: Fri, 6 Dec 2002 12:48:43 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, david@gibson.dropbear.id.au,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206174843.GA15923@gnu.org>
References: <200212060714.XAA06006@adam.yggdrasil.com> <200212061626.gB6GQvl01748@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212061626.gB6GQvl01748@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 10:26:57AM -0600, James Bottomley wrote:
> I'm not so keen on this.  The idea of this parameter is not to tell the 
> allocation routine what type of memory you would like, but to tell it what 
> type of memory the driver can cope with.  I think for the inconsistent case, 
> DMA_INCONSISTENT looks like the driver is requiring inconsistent memory, and 
> expecting to get it.

Of course if they're flags, then `DMA_CONSISTENT | DMA_INCONSISTENT'
is pretty obvious...

-Miles

-- 
P.S.  All information contained in the above letter is false,
      for reasons of military security.
