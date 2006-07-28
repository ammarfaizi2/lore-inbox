Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWG1DeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWG1DeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWG1DeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:34:08 -0400
Received: from web36712.mail.mud.yahoo.com ([209.191.85.46]:60808 "HELO
	web36712.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751408AbWG1DeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:34:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SIOdYg1Q4cj7UIVevdQcWz2KOoxnc4OZhLcKg78/OzTdOepl1SDW63n+jZioSKCxIHc9GGNn5HCswjoazWN2lPvlKha41AtjdnA7GOCLBEemA2x4TXDeBAnfo+oGmnhpwcZAs7tY+J0MeD4Ree3Q59Z32F1RxxiAXiQhtV/l1ro=  ;
Message-ID: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
Date: Thu, 27 Jul 2006 20:34:06 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to announce the availability of the
driver for TI FlashMedia flash card readers. Currently
supported pci ids:
1. 104c:8033.3
2. 104c:803b.2

Device with id 8033 also features sdhci interface (as
subfunction 4). However, sdhci is disabled on many
laptops (notably Acer's), while FlashMedia interface
is available.

The driver is called tifmxx and available from:
http://developer.berlios.de/projects/tifmxx/

Only mmc/sd cards are supported at present, via mmc
subsystem. Provisions for other card types (Sony MS,
xD and such) are in place, but no support is available
due to lack of hardware and interest.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
