Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUDALN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbUDALN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:13:57 -0500
Received: from mail1.kontent.de ([81.88.34.36]:11913 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262841AbUDALN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:13:56 -0500
From: Oliver Neukum <oliver@neukum.org>
To: "Jinu M." <jinum@esntechnologies.co.in>,
       "Arjan van de Ven" <arjanv@redhat.com>
Subject: Re: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 13:13:50 +0200
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A972176F98@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A972176F98@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404011313.50530.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. April 2004 12:47 schrieb Jinu M.:
> cool; linux can use a GPL driver for such things...
>
> [jinum] guess the question/clarification is not clear!
> This is a driver for our own controller (PCI). Which is a PCI based
> card.
> This card is not based on the SCSI or IDE interface so how will some
> other driver work for it unless we write ( or get it written sharing our
> hardware spec) a driver for the interface?

It will not work. A block driver must be written for such hardware to make
it work.

	Regards
		Oliver

