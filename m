Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTEKXzv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 19:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEKXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 19:55:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261544AbTEKXzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 19:55:50 -0400
Date: Sun, 11 May 2003 17:07:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <1052687076.30359.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305111706370.22268-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 May 2003, Alan Cox wrote:
> 
> Some laptops also lose all the AGP settings in the chipset.

Well, that's definitely a driver issue, and should be handled that way. I
suspect even the MTRR's should be handled as a driver, since unlike things
like the SYSENTER things, it really _is_ a driver already and is
conditional on kernel configuration etc.

		Linus

