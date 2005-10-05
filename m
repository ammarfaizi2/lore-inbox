Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVJEPK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVJEPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVJEPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:10:28 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:20151 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S965207AbVJEPK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:10:27 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=b6I2RZhtLbExbxierY8IfSTgQJYsYBYGrh4wH0dEQ4Ndy2wUiOhOwVwIY/6WJbSb9
	1fASKMsKxVPKM+iBP7Pzw==
Date: Wed, 05 Oct 2005 08:10:24 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005151024.A8282EE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, haven't seen any place where message->complete() is called... Can 
> you please point out one?

There are calls to that from the pxa2xx_spi_ssp.c controller driver
which Stephen Street posted.

  http://marc.theaimsgroup.com/?l=linux-kernel&m=112846505323865&w=2

Unfortunately he's struggling with mailers that are mangling
his patches (tabs-to-spaces, quoted-printable, base64, etc)
so you'll have to cope for a while with wrong-formatting.

I didn't post the OMAP MicroWire driver since I've not yet split
it out from the previous non-drivermodel support, so the patch
would be useless to anyone not working with the Linux-OMAP tree.

- Dave

