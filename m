Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265458AbTF1XG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTF1XG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:06:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20107
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265458AbTF1XGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:06:25 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edward Tandi <ed@efix.biz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1056840603.30264.45.camel@wires.home.biz>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 00:17:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 23:50, Edward Tandi wrote:
> > > using option 'pci=noacpi' or even 'acpi=off'
> > > Jun 28 18:27:46 machine kernel: BIOS failed to enable PCI standards
> > > compliance, fixing this error.
> > 
> > Start by upgrading to their current BIOS
> 
> Believe or not, it _is_ the latest bios for that board
> (Tyan S2460 BIOS v1.05, 2nd Jan 2003).

Then I guess you have a problem. We try and fix up BIOS problems but there
is a limit to what we can do, and if it has problems like the one that is
logged I'd be worried what else it might do - eg I suspect Nvidia 4x AGP cards
aren't too solid on it.

The APIC errors also suggest something isn't happy at all at the hardware
layer. Are you using MP processors ?

