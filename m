Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUBTWhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUBTWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:37:50 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:30658 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S261328AbUBTWhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:37:43 -0500
Date: Fri, 20 Feb 2004 15:37:50 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
Message-ID: <20040220223750.GA8427@bounceswoosh.org>
Mail-Followup-To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>,
	Nico Schottelius <nico-kernel@schottelius.org>,
	Bruce Allen <ballen@gravity.phys.uwm.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0402181039520.8134-100000@dirac.phys.uwm.edu> <Pine.LNX.4.58.0402182002180.11305@brain.fop.ns.ca> <20040219081642.GE25184@schottelius.org> <Pine.LNX.4.58.0402201407480.1167@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402201407480.1167@pervalidus.dyndns.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20 at 14:10, Frédéric L. W. Meunier wrote:
>It isn't that hot, and by ambient temperature I assume it's the
>local temperature, not of the hard drive.
>
>194 Temperature_Celsius     0x0022   079   074   042    Old_age   Always       -       54
>
>and has been running almost fine for over 2 years.

The SMART data is the temperature recorded by the drive itself.  There
are various places where these measurements may be made, the actual
implementation is vendor specific.

An ambient temperature exceeding 55C would void most drive warranties,
it isn't a good idea.  Sure, your drive may survive at higher temps,
but it really is a bad idea.


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

