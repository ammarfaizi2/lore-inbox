Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWCLSIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWCLSIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWCLSIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 13:08:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19076 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751661AbWCLSIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 13:08:23 -0500
Subject: RE: Router stops routing after changing MAC Address
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Scott <GregScott@InfraSupportEtc.com>
Cc: linux-kernel@vger.kernel.org, Bart Samwel <bart@samwel.tk>
In-Reply-To: <925A849792280C4E80C5461017A4B8A20321DD@mail733.InfraSupportEtc.com>
References: <925A849792280C4E80C5461017A4B8A20321DD@mail733.InfraSupportEtc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Mar 2006 18:14:13 +0000
Message-Id: <1142187253.20056.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-03-12 at 09:34 -0600, Greg Scott wrote:
> Bart and I had a private discussion about this.  I was able to prove
> that routing stops when "fudged" MAC Addresses on the router don't match
> the hardware MAC Addresses.  And routing starts back up again when the I
> change the "fudged" MAC Addresses back to match the hardware MAC
> Addresses.  

Which driver, and does it occur with other drivers. Also you really want
to move this to netdev@oss.sgi.com to get the best network folks to see
it.

