Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWEFOIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWEFOIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 10:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEFOIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 10:08:54 -0400
Received: from keetweej.vanheusden.com ([213.84.46.114]:62392 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1750824AbWEFOIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 10:08:54 -0400
Date: Sat, 6 May 2006 16:08:51 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: mpm@selenic.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060506140850.GN25646@vanheusden.com>
References: <2.420169009@selenic.com> <8.420169009@selenic.com>
	<20060505.141040.53473194.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505.141040.53473194.davem@davemloft.net>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Apr 29 15:52:22 CEST 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Remove SA_SAMPLE_RANDOM from network drivers
> > /dev/random wants entropy sources to be both unpredictable and
> > unobservable. Network devices are neither as they may be directly
> > observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is not
> > appropriate.
> Besides the other issues discussed, what you are doing is
> essentially making a headless machine with a quiet disk have
> next to zero entropy available.

Consider adding a cheap soundcard to the system and run
'audio-entropyd': www.vanheusden.com/aed


Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
