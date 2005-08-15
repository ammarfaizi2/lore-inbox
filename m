Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVHOAxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVHOAxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 20:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVHOAxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 20:53:41 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:62657 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932617AbVHOAxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 20:53:41 -0400
Date: Mon, 15 Aug 2005 02:53:34 +0200
From: Voluspa <voluspa@telia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Message-Id: <20050815025334.1f289ec2.voluspa@telia.com>
In-Reply-To: <1124066229.29265.2.camel@localhost.localdomain>
References: <20050815005101.26df083a.voluspa@telia.com>
	<1124066229.29265.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 01:37:08 +0100 Alan Cox wrote:
> 
> We certainly could interpret 0x51, 0x04 specifically. Its not an "error"
> in the usual spew at the user case generally speaking but a "do this"
> "no" sequence. Its useful to log because sending unknown commands to an
> IDE device is something we want to catch (some drives hang if you do it,
> others do really *crazy* things).
> 
> Would
> 
> hdc: command not supported by drive
> ide: failed opcode was: 0xec
> 
> have been more helpful 

If it was clearly marked as "This is INFO, not a Warning". Most users
I've met (myself included) are always expecting their hardware to crash and
burn at the drop of a hat. Scary messages just confirm our anguish - 
especially when it's coming by way of the CD/HD system.

Mvh
Mats Johannesson
--
