Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUIRXLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUIRXLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUIRXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:11:19 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:28883 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S269658AbUIRXLR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:11:17 -0400
From: Max Valdez <maxvalde@fis.unam.mx>
Organization: CCF
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] pmac: don't add "=?iso-8859-15?q?=B0C?=" suffix in sys for adt746x driver
Date: Sat, 18 Sep 2004 18:09:46 -0500
User-Agent: KMail/1.6.82
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1095401127.5105.73.camel@gaston> <Pine.GSO.4.58.0409171249500.19914@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0409171249500.19914@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409181809.46323.maxvalde@fis.unam.mx>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 05:50, Geert Uytterhoeven wrote:
> On Fri, 17 Sep 2004, Benjamin Herrenschmidt wrote:
> > The adt746x driver currently adds a "°C" suffix to temperatures exposed
> > via sysfs, and I don't like that. First, we all agree that any other unit
> > here makes no sense (do we ? do we ? yes of course :) and I don't like
>
> Universal temperature, in K? And you'll never ever see negative numbers ;-)
It's called Absolute Temperature, (Kelvins for thos who dont know) :-)

Sorry for the nerdy comment, can't help it

Max

-- 
Linux garaged 2.6.9-rc1-mm1 #3 SMP Mon Aug 30 12:14:50 CDT 2004 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-- 
V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt
