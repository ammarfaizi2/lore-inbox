Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbTF2Kau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 06:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTF2Kau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 06:30:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34444
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265622AbTF2Kat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 06:30:49 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edward Tandi <ed@efix.biz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1056844328.2315.22.camel@wires.home.biz>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
	 <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
	 <1056844328.2315.22.camel@wires.home.biz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056883336.16253.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 11:42:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 00:52, Edward Tandi wrote:
> It does have an AGP NVidia card in it. I'm using the standard XFree
> drivers with it at the moment but I have played UT on it for hours
> before (using NVidia drivers) without problems. It might be an AGP x2
> card though. The computer is now mostly a back-end server and I haven't
> really pushed it on the graphics side recently
> 
> Could the problem be caused by some BIOS setting? I could spend some
> time looking at them.

The BIOS has magic tuning tables for AMD76x chipsets for various video
cards. Its one of the reasons that new BIOSes sometimes make AGP 4x
work, or more reliable.

> The version running prior to this one was 2.4.21-rc3. This version
> allowed me to specify noapic.

Out of interest, compile out ACPI support and see what it does

