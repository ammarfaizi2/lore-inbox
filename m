Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUF3QW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUF3QW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUF3QW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:22:58 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:36023 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266737AbUF3QU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:20:57 -0400
Date: Wed, 30 Jun 2004 18:20:54 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Tom Felker <tcfelker@mtco.com>
Cc: Sean Champ <gimbal@sdf.lonestar.org>, linux-kernel@vger.kernel.org
Subject: Re: problems with CF card reader, kernel 2.6.7
Message-ID: <20040630162054.GA22476@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Tom Felker <tcfelker@mtco.com>,
	Sean Champ <gimbal@sdf.lonestar.org>, linux-kernel@vger.kernel.org
References: <20040630101605.GA3568@tokamak.homeunix.net> <200406301108.02618.tcfelker@mtco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406301108.02618.tcfelker@mtco.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a stab in the dark, but try running "eject /dev/sg0" on the generic
> device coresponding to the card reader (or maybe the disc device, I'm not
> sure), after putting the new card in.  This forces the kernel to reread the
> card's partition table.

Actually, this is better done with "blockdev --rereadpt /dev/sda" or similar.

Rudo.
