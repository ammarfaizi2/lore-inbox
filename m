Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVADVdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVADVdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVADVS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:18:27 -0500
Received: from mail1.kontent.de ([81.88.34.36]:20198 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262118AbVADVOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:14:37 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 6/6] delete unused file
Date: Tue, 4 Jan 2005 22:14:25 +0100
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, domen@coderock.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041226153257.0F3501F126@trashy.coderock.org> <1104081178.15994.11.camel@localhost.localdomain> <20050104210342.GA2995@waste.org>
In-Reply-To: <20050104210342.GA2995@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501042214.25912.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. Januar 2005 22:03 schrieb Matt Mackall:
> On Sun, Dec 26, 2004 at 05:13:00PM +0000, Alan Cox wrote:
> > On Sul, 2004-12-26 at 15:33, domen@coderock.org wrote:
> > > Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> > 
> > This file is there for a reason - it completes the set of endian types
> > should anyone port to a mixed endian system.
> 
> Please name one such box that doesn't support a more sensible order
> and is vaguely Linux-capable. The PDP-11 does not qualify, as it's
> only 16-bit and could be made to DTRT for 32-bit values in the
> compiler if you were going to go to the trouble of making "int" and
> "void *" 32 bits on a 16-bit arch and then trying to fit the
> resulting bloated code in the 4MB the later PDP-11s supported.

You don't a machine that will have the endianness. As long as you exchange
data in that format, you'll have to convert endianness.

	Regards
		Oliver
