Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFGAuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFGAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:50:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36244
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262427AbTFGAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:49:05 -0400
Subject: Re: Using SATA in PATA compatible mode?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054932405.2156.5.camel@paragon.slim>
References: <1054932405.2156.5.camel@paragon.slim>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jun 2003 02:00:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 21:46, Jurgen Kramer wrote:
> I've read somewhere that the SATA controllers are backward compatible
> with PATA controllers. Does this mean that a SATA controller can be used
> with standard PATA drivers (especially the Intel ICH5)?

I'm not totally sure about the status of the SATA on the Intel right
now. I was under the impression it was very similar to the PATA.

For some of the others its a bit variable:
	HPT some people report work some dont
	Promise 20376 - Promise have a GPL driver but there are integration
things to resolve (mostly our end not theirs)
	SI 3112 - Now works well with almost all drives. 
	3Ware SATA raid - works

