Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVDDPlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVDDPlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDDPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:41:46 -0400
Received: from webapps.arcom.com ([194.200.159.168]:16906 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261258AbVDDPlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:41:45 -0400
Message-ID: <42516034.7000802@arcom.com>
Date: Mon, 04 Apr 2005 16:41:40 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
References: <1112475134.5786.29.camel@mulgrave>	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>	 <20050402183805.20a0cf49.davem@davemloft.net>	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>	 <1112499639.5786.34.camel@mulgrave>	 <20050402200858.37347bec.davem@davemloft.net>	 <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston> <1112623143.5813.5.camel@mulgrave>
In-Reply-To: <1112623143.5813.5.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2005 15:48:34.0218 (UTC) FILETIME=[C211B8A0:01C5392D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> so can you provide an example of a BE bus (or device) used on a LE
> platform that would actually benefit from this abstraction?

The Network Processing Engines in the Intel IXP425 are big-endian and
its XScale core may be run in little-endian mode. There's a bunch of
gotchas related to running in little-endian mode so you typically run
the IXP425 in big-endian mode, though.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
