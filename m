Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272913AbTG3OxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272885AbTG3OxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:53:02 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:64756 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272935AbTG3OvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:51:01 -0400
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
	2.5.31 (incl. 2.6.0testX)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: clepple@ghz.cc, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730110548.73919ca0.sfr@canb.auug.org.au>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
	 <1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
	 <32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
	 <1059502242.5987.24.camel@dhcp22.swansea.linux.org.uk>
	 <20030730110548.73919ca0.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059576198.8041.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 15:43:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 02:05, Stephen Rothwell wrote:
> > It might be 0x00009300, it might be set already, or it might be some other
> > effect thats breaking your laptop of course
> 
> The 0 above initialises the base and limit parts of the descriptor and
> should be zero as it is filled in later (or should be).

I thought the descriptor bits came in the first long word and the 16bit
base/limit in the second ?


