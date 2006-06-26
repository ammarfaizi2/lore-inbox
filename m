Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWFZNRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFZNRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWFZNRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:17:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:51065 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932269AbWFZNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:17:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QRjVWfJs25q0w+2BnQuHYyjBYC63DG/6xVLJGKgnK12UVnT7EBMD2EvZWr3JpirPel5iK55vpbnblow40gpFk3qBtBopl7kOorOSjTP55HzvYUd5GbT/bfufZjfbCvLMWUyC0JFVwYpp0NQBzU+wpmfIri2sTCuQmgkFLaHWRyQ=
Message-ID: <2cf1ee820606260617v7ea151c7kf5f7935da87adae6@mail.gmail.com>
Date: Mon, 26 Jun 2006 16:17:43 +0300
From: "emin ak" <eminak71@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: huge performance loss with ipsec 2.6.16.20 on ppc85xx
In-Reply-To: <2cf1ee820606260616v2583c063w20caac144b52ccbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2cf1ee820606260616v2583c063w20caac144b52ccbb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
I'am planning to use linux  2.6 ipsec for an vpn design with an
embedded powerpc (mpc85xx) family. Basic routing performance looks
pretty for the system with 2.6.16.20 kernel
---------------------------------------------------
Basic routing performance on ppc85xx
64Byte packets:         230680 pps
512 Byte packets:       176221 pps
1518 Byte packets:      77617 pps
---------------------------------------------------
Software AES 256 ipsec tunnel mode routing performance (with manual keyying):
64Byte packets:      55059pps (-%76 lesser then normal routing)
512 Byte packets:   23496 pps (-%87 lesser then routing)
1518 Byte packets:  8533 pps (-%90  lesser then  routing)
-----------------------------------------------------

I know software encryption/ decryption affects system performance
alot, but isn't %90 decreasement  so much for this effect?

Is there any ipsec performance benchmark  with same of different
platform, or anyting wrong with my tests?
Thanks alot for the responses..
Regads
Emin Ak
