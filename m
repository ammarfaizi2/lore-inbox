Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTHZWxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTHZWxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:53:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53175 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262654AbTHZWxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:53:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Niehusmann <jan@gondor.com>
Subject: Re: Promise IDE patches
Date: Wed, 27 Aug 2003 00:54:27 +0200
User-Agent: KMail/1.5
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
References: <20030826223158.GA25047@gondor.com>
In-Reply-To: <20030826223158.GA25047@gondor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270054.27375.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Jan.

Marcelo can you apply these patches?

On Wednesday 27 of August 2003 00:31, Jan Niehusmann wrote:
> Hi!
>
> Two weeks ago, I tried two patches against 2.4.21 regarding LBA48
> support. One limits the size of a drive to 137GB if LBA48 is not
> available. Without this patch, severe data corruption is possible.
>
> http://gondor.com/linux/patch-limit48-2.4.21
>
> The other one is making LBA48 support work with pdc 20265 controllers.
>
> http://gondor.com/linux/patch-pdc-lba48-2.4.22
>
> I think they should be candidates for inclusion in 2.4.23, as well as
> a fix for hdparm -I (and other commands going directly to the drive) on
> (some?) promise controllers:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104250818527780&w=2
>
> Jan

