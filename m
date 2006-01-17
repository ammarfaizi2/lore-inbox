Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWAQRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWAQRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWAQRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:03:25 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:14307 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932181AbWAQRDY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:03:24 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Suggested janitor task - remove __init/__exit from function prototypes
Date: Tue, 17 Jan 2006 19:01:57 +0200
User-Agent: KMail/1.9.1
References: <31582.1137291095@ocs3.ocs.com.au> <Pine.LNX.4.61.0601171754270.18569@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601171754270.18569@yvahk01.tjqt.qr>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601171901.57621.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salı 17 Ocak 2006 18:55 tarihinde şunları yazmıştınız:
> >Some function prototypes (in both .h and .c files) specify attributes
> >like __init and __exit in the prototype.  gcc (at least at 3.3.3) uses
> >the last such attribute that is actually specified, without issuing a
> >warning.
>
> How does gcc 2.95 handle it, requiring __init in both spots?

gcc 3.2 is now required for mainline kernel.

/ismail
