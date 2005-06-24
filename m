Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbVFXSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbVFXSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVFXSjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:39:04 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:4240 "EHLO bizon.gios.gov.pl")
	by vger.kernel.org with ESMTP id S263190AbVFXSfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:35:38 -0400
Date: Fri, 24 Jun 2005 20:35:24 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Mark Lord <liml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: SATA speed. Should be 150 or 133?
In-Reply-To: <42BC284E.7050202@rtr.ca>
Message-ID: <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
 <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl>
 <42BC284E.7050202@rtr.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-481984758-1119638124=:1394"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-481984758-1119638124=:1394
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Fri, 24 Jun 2005, Mark Lord wrote:

<CUT>
>> Oh, so how to check true (current) speed?
> Same as always:  hdparm -I /dev/sd?
> (requires the libata-dev "passthru" patch
> recently reposted here by Jeff Garzik).

Got it :)

# hdparm -I /dev/sda

/dev/sda:
(...)
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
(...)

This one? udma6?

Best regards,


 =09=09=09Krzysztof Ol=EAdzki
---187430788-481984758-1119638124=:1394--
