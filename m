Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUGBNcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUGBNcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGBNcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:32:31 -0400
Received: from atropo.wseurope.com ([195.110.122.67]:5608 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S264500AbUGBNca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:32:30 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: SATA problems in 2.6.7-mm[1,5] vanilla works
Date: Fri, 2 Jul 2004 15:32:27 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407012352.16816.cova@ferrara.linux.it> <200407020025.02274.cova@ferrara.linux.it> <cc2i2r$6ta$2@news.cistron.nl>
In-Reply-To: <cc2i2r$6ta$2@news.cistron.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407021532.27730.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 04:42, venerdì 2 luglio 2004, Danny ter Haar ha scritto:

>
> Strange, since my problem (ICH5 sata controller) does function with
> acpi=off . What hardware do you have ? (mobo/controller)

Abit IC7-G; maybe it's possible that having an aic7xxx on pci bus can collide 
with libata...
I can try to save the kernel oops that occurs during the sata detection phase 
at boot.

-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

