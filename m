Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbTL3Xej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbTL3Xej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:34:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39867 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265808AbTL3Xeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:34:37 -0500
Message-ID: <3FF20B7A.1090108@pobox.com>
Date: Tue, 30 Dec 2003 18:34:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adaptec 1210sa
References: <200312220305.29955.marchand@kde.org>
In-Reply-To: <200312220305.29955.marchand@kde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> reading linux-scsi I found a suggestion by Justin to make adaptec's 1210 sa 
> working. I made the corresponding patch for libata, and it actually works :)
> 
> it needs  some redesign to only apply to aar1210 (as standard sil3112 does not 
> need it) and I guess some testing before inclusion.
> 
> the idea suggested by Justin was to clear bits 6 and 7 at 0x8a of pci 
> configuration space. (which I hope did fine :)
> 
> Thanks Justin :)


Does the aar1210 have a different PCI id?  That would make it easy to 
distinguish, and thus easy to selectively apply your patch only to 
Adaptec chipsets that need it.

	Jeff



