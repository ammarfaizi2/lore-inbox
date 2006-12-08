Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425484AbWLHM1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425484AbWLHM1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425485AbWLHM1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:27:33 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48917 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425484AbWLHM1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:27:32 -0500
Message-ID: <45795A32.30107@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 13:27:30 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Matthias Schniedermeyer <ms@citd.de>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       DervishD <lkml@dervishd.net>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <45793D82.1040807@s5r6.in-berlin.de> <457940DC.90403@citd.de> <200612081201.36789.oliver@neukum.org>
In-Reply-To: <200612081201.36789.oliver@neukum.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 8. Dezember 2006 11:39 schrieb Matthias Schniedermeyer:
>> > Also, you mentioned that the corruption occurs systematically on certain
>> > byte patterns. Therefore it's certainly not related to the cables.
>> 
>> It'd guess that too, but who can that say for sure. :-|
> 
> You may have a bit pattern that stresses the controllers and suddenly
> a marginal cable may matter.

And one more thing: I heard of FireWire enclosures which corrupted data
(although AFAIR with error detection by the drivers) due to overheating
PHY chip or bridge chip. Gluing a small passive heat sink to the
respective chip solved it in the reported case.
-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/
