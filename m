Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264996AbTFCNIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbTFCNIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:08:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17130
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264996AbTFCNIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:08:15 -0400
Subject: Re: lost interrupts with 2.4.1-rc6 and i875p chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Norris <haphazard@kc.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030603111519.GA23228@glitch.localdomain>
References: <20030603111519.GA23228@glitch.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054642710.9234.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 13:18:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 12:15, Greg Norris wrote:
> I recently installed Debian on a new i875P chipset machine, and I'm
> seeing frequent "hdX: lost interrupt" messages at the console under
> 2.4.21-rc6.  The IDE system appears to stall for 5 seconds or so
> whenever this occurs (I assume that a reset/resync is occurring), but
> then seems to recover.  It's pretty easy to reproduce... any
> significant disk activity will trigger the problem.  In particular,
> running fsck or copying files off a cdrom will expose the problem
> within seconds.

Does this occur if you build the kernel without ACPI and without APIC
support ?

