Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVHINFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVHINFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVHINFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:05:55 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:43476 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932533AbVHINFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:05:54 -0400
Date: Tue, 9 Aug 2005 09:05:53 -0400
To: Shaun Jackman <sjackman@gmail.com>
Cc: debian-boot@lists.debian.org, debian-user@debian.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: SATALink Sil3112 and Linux woes
Message-ID: <20050809130553.GE6714@csclub.uwaterloo.ca>
References: <7f45d9390508081645c1afd1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390508081645c1afd1c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 11:45:22PM +0000, Shaun Jackman wrote:
> I have a Silicon Image SATALink Sil3112 PCI card connected to two 200
> GB SATA Seagate drives.  I'm running into many problems with this
> setup. Is this card well supported under Linux? If it's a black sheep,
> could someone please recommend a PCI SATA card that works well?

There have certainly in the past been known problems with Sil SATA
controllers and Seagate drives due to both doing something stupid as far
as I understand it.  It seems this only applies to seagate drives with
an ide to sata convert onboard rather than a true native sata drive
(which only very resent models would be).  It also seems only the
Sil3112 controller has a stupid assumption that upsets the seagate sata
to ide convertor.

> I am really having no luck. I would love to...
>   solve the ten-minute boot delay issue
>   replace the Sil3112 with a better supported card
>   use Knoppix to somehow fix my newly installed Debian partition

Well if what I have read about Sil + Seagate is correct, you can either
replace the drives with drives that follow the SATA standard correctly
(WD, Maxter, etc) or you can find another supported controller chip and
get a card using that.

I have no problem with the Sil3112A myself on an Asus board using WD
drives.

For me personally it has been simpler to avoid seagate drives than to
avoid Sil controllers given how often they are used as onboard
controllers on motherboards.

Len Sorensen
