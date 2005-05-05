Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVEELOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVEELOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVEELOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:14:10 -0400
Received: from animx.eu.org ([216.98.75.249]:49290 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262033AbVEELOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:14:06 -0400
Date: Thu, 5 May 2005 07:13:24 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505111324.GA17223@animx.eu.org>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050505031041c2c164@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 5/5/05, Wakko Warner <wakko@animx.eu.org> wrote:
> > If this interface is obsolete and will be removed, is there any non-obsolete
> > way of telling the kernel what geometry I want to use for this ide device?
> 
> Yes, physical geometry - through boot parameters and logical geometry
> is not needed for IDE layer to function properly.

I did not ask if it was needed for it to function, I asked how to set it
since the "settings" file is obsolete.  Yes, I do need to set this.  I want
to know what the "non-obsolete" way is.  A project I'm working on uses linux
to do something with the drive and that is dependant on the geometry that
linux provides to programs be the same as what the bios thinks.  I know how
to obtain the bios values.  I have to set these values to the kernel so
everything functions properly.

If there is no "non-obsolete" way of doing this, then fine, I'll continue
with the settings thing.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
