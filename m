Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbTBNKGW>; Fri, 14 Feb 2003 05:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268338AbTBNKGW>; Fri, 14 Feb 2003 05:06:22 -0500
Received: from mail.scram.de ([195.226.127.117]:19911 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S268337AbTBNKGV>;
	Fri, 14 Feb 2003 05:06:21 -0500
Date: Fri, 14 Feb 2003 11:15:27 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Olivier Galibert <galibert@pobox.com>, <mike_phillips@urscorp.com>,
       <phillim2@comcast.net>, Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] smctr.c changes in latest BK
In-Reply-To: <20030214044818.A5658@kerberos.ncsl.nist.gov>
Message-ID: <Pine.LNX.4.44.0302141106340.28838-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

> Doesn't that mean that the original function was buggy and it should
> not have copied the mac address over if one was user-provided?

Right. But for now i preferred to clean up the offending code. The driver
still needs some serious cleanup (not 64bit clean, lots of IMHO
unnecessary and confusing casts, not using propper reference counting,
and probably some more), so i plan to clean up those first before adding
new features to the driver.

Fortunately, i recently go hold of one of these cards, so i will be able
to test the cleanup on my Alpha for 64bit cleanliness :-)

Cheers,
--jochen

