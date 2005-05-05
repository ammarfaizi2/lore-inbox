Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVEEPe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVEEPe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVEEPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:34:28 -0400
Received: from animx.eu.org ([216.98.75.249]:5515 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262008AbVEEPeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:34:16 -0400
Date: Thu, 5 May 2005 11:33:27 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505153327.GA17724@animx.eu.org>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050505051360d0588c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 5/5/05, Wakko Warner <wakko@animx.eu.org> wrote:
> > If there is no "non-obsolete" way of doing this, then fine, I'll continue
> > with the settings thing.
> 
> Please be aware that new applications are expected to use
> /sys/firmware/edd/default_* instead of legacy HDIO_GETGEO ioctl
> and there is currently no way to set these sysfs entries (maybe it
> would be worthwile to add such functionality?).

I am using edd to retrieve these parameters.  Unfortunately there are some
utils that I use that I cannot give it the geometry.  Those utils depend on
having the proper geometry so that the system can boot properly (no, it's
not booting linux).

I need to work around what I can't fix otherwise.  So far, the proc entry is
the only solution I have seen.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
