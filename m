Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUAWM5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 07:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUAWM5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 07:57:43 -0500
Received: from aun.it.uu.se ([130.238.12.36]:59592 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261552AbUAWM5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 07:57:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16401.6720.115695.872847@alkaid.it.uu.se>
Date: Fri, 23 Jan 2004 13:57:36 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] local APIC LVTT init bug
In-Reply-To: <Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
References: <16400.9569.745184.16182@alkaid.it.uu.se>
	<Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > On Thu, 22 Jan 2004, Mikael Pettersson wrote:
 > 
 > > __setup_APIC_LVTT() incorrectly sets i82489DX-only bits
 > > which are reserved in integrated local APICs, causing
 > > problems in some machines. Fixed in this patch by making
 > > this setting conditional.
 > 
 >  Sigh -- why can't designers keep such a trivial backwards
 > compatibility???  The integrated APIC was said to be backwards compatible
 > when introduced and so far all implementations used to.  What you write
 > means that has been broken -- could please say which vendor to blame?

The ASUS L3800C was mentioned. I don't know of any others.

 >  Your proposal is therefore the only correct one.

Thanks for confirming that.

/Mikael
