Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSBBXlg>; Sat, 2 Feb 2002 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBBXlZ>; Sat, 2 Feb 2002 18:41:25 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:38107 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S282967AbSBBXlU>;
	Sat, 2 Feb 2002 18:41:20 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: SIOCDEVICE ?
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com>
	<20020131181241.A3524@fafner.intra.cogenit.fr>
	<m3665iqhqn.fsf@defiant.pm.waw.pl>
	<20020202154424.A5845@fafner.intra.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 02 Feb 2002 20:14:44 +0100
In-Reply-To: <20020202154424.A5845@fafner.intra.cogenit.fr>
Message-ID: <m3wuxvofvf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> Your patch doesn't apply against 2.5.3. I did a quick update and noticed the
> patch is the sole user of SIOCDEVICE (with dscc4) and SIOCDEVPRIVATE.

SIOCDEVICE, yes. That's my attempt to create an ioctl interface for
controlling devices. It's defined by the hdlc patch, discussed about
a year (?) ago here. Yes, I think I should post a note here.

SIOCDEVPRIVATE - an older method of controlling net devices. IMHO, not
very useful, could possibly be used as a devel hack. Many net drivers
use it.

A new patch which applies to 2.5.3 is in the usual place:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/
This is what I want included in base kernel.
-- 
Krzysztof Halasa
Network Administrator
