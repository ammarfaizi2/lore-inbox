Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290644AbSBFQEH>; Wed, 6 Feb 2002 11:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSBFQD5>; Wed, 6 Feb 2002 11:03:57 -0500
Received: from air-2.osdl.org ([65.201.151.6]:49422 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S290640AbSBFQDu>;
	Wed, 6 Feb 2002 11:03:50 -0500
Date: Wed, 6 Feb 2002 07:59:48 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Rohland <cr@sap.com>, <Andries.Brouwer@cwi.nl>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16YSs7-0005GY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L2.0202060758340.18426-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Alan Cox wrote:

| > > If you are going to cat it onto the end of the kernel image just
| > > mark it __initdata and shove a known symbol name on it. It'll get
| > > dumped out of memory and you can find it trivially by using tools on
| > > the binary
| >
| > What about putting such info into a (swappable) tmpfs file with
| > shmem_file_setup?
|
| That is indeed an extremely cunning plan. Paticularly as /proc/config can
| be a symlink to it
| -

I still prefer your suggestion to append it to the kernel image
as __initdata so that it's discarded from memory but can be
read with some tool(s).

-- 
~Randy

