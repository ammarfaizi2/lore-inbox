Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUHHNjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUHHNjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 09:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUHHNjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 09:39:42 -0400
Received: from cmu-24-35-116-59.mivlmd.cablespeed.com ([24.35.116.59]:7155
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S265331AbUHHNjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 09:39:41 -0400
Date: Sun, 8 Aug 2004 09:39:26 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <Pine.LNX.4.58.0408072250370.1793@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408080936040.4368@localhost.localdomain>
References: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
 <20040807114046.GA5249@ucw.cz> <Pine.LNX.4.58.0408072250370.1793@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've had our regularly-scheduled cdrecord imbriglio (my word for 
today), can we get on to one of our other periodic arguments?

> Joerg is wrong. SCSI number simply doesn't work, and the current Linux 
> setup is absolutely the right thing to do.
> 
> If Joerg keeps breaking cdrecord, the distributions will hopefully just 
> keep unbreaking it. The way you send SCSI commands to a device under Linux 
> is to open the device (with O_NDELAY) and then just start sending the 
> commands. None of the idiotic scanning and SCSI numbering crap.
> 
> Involving Joerg in it just makes you go crazy. Don't bother.
