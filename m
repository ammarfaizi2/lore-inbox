Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVLUTgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVLUTgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLUTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:36:36 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:33431 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751193AbVLUTgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:36:36 -0500
Date: Wed, 21 Dec 2005 20:36:34 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Dave Jones <davej@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
	on	x86_64 machines ?
Message-ID: <20051221193634.GH31514@vanheusden.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	<43A91C57.20102@cosmosbay.com> <200512210744.52559.edt@aei.ca>
	<20051221132046.GJ27831@vanheusden.com>
	<43A95ABF.1030309@cosmosbay.com>
	<20051221140901.GM27831@vanheusden.com>
	<20051221164024.GB3459@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221164024.GB3459@redhat.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Thu Dec 22 16:38:56 CET 2005
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > Your results are interesting : size-32 seems to use objects of size 64 !
>  > > > size-32             1538   2714     64 <<HERE>>
>  > > So I guess that size-32 cache could be avoided at least for EMT (I take you 
>  > > run a 64 bits kernel ?)
>  > I think I do yes:
>  > Linux xxxxx 2.4.21-37.EL #1 SMP Wed Sep 7 13:32:18 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
>  > It is a redhat 4 x64 system.
> Looks more like RHEL3 judging from the kernel version.

Ehr yes, you're totally right.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
