Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUBXPph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUBXPph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:45:37 -0500
Received: from ee.oulu.fi ([130.231.61.23]:30462 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262281AbUBXPpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:45:36 -0500
Date: Tue, 24 Feb 2004 17:44:47 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver
Message-ID: <20040224154446.GA28720@ee.oulu.fi>
References: <200402241110.07526.andrew@walrond.org> <403B6BF3.8070301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <403B6BF3.8070301@pobox.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:21:23AM -0500, Jeff Garzik wrote:
> Andrew Walrond wrote:
> >I've got a 378 s150 tx chipset with their fasttrak raid bios. How should I 
> >configure the drives to use with the 2.6.3 kernel promise SATA driver? Can 
> >I configure them as a raid array?
> 
> The 2.6.3 sata_promise driver ignores any RAID configuration you set up, 
> and directly talks to the drives.
To boot off one you might have to setup a RAID configuration in the
card BIOS though (Which is why I have a single drive configured as a raid0 :-) )
