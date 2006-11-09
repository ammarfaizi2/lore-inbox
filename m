Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753813AbWKIHsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbWKIHsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbWKIHsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:48:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49313 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753813AbWKIHsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:48:14 -0500
Subject: Re: Abysmal PATA IDE performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Stephen Clark <Stephen.Clark@seclark.us>, Mark Lord <lkml@rtr.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061109020758.GA21537@atjola.homenet>
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
	 <455277E1.3040803@seclark.us>  <20061109020758.GA21537@atjola.homenet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 09 Nov 2006 07:52:35 +0000
Message-Id: <1163058755.23956.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-09 am 03:07 +0100, ysgrifennodd Björn Steinbrink:
> Appears first and that's where the other driver has taken control of the
> drives. I had the same issue on my thinkpad, getting rid of the whole
> IDE stuff solved the problem (because the other drivers does no longer
> grab the drive).

For reference you can also use ide0=noprobe ide1=noprobe and similar to
control this
