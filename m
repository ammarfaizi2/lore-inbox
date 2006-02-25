Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWBYJgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWBYJgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 04:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWBYJgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 04:36:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41197 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030188AbWBYJgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 04:36:50 -0500
Date: Sat, 25 Feb 2006 10:36:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ben Pfaff <blp@cs.stanford.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
In-Reply-To: <87oe0wxryk.fsf@benpfaff.org>
Message-ID: <Pine.LNX.4.61.0602251036080.1479@yvahk01.tjqt.qr>
References: <200602242149.42735.jesper.juhl@gmail.com>
 <1140821964.3615.95.camel@lade.trondhjem.org>
 <9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
 <20060224231749.GH27946@ftp.linux.org.uk> <87oe0wxryk.fsf@benpfaff.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> No need for that. It's just something that ICC complains about
>>> "storage class not being first" - gcc doesn't care.
>>
>> Neither does C99, so ICC really should either STFU or make that warning
>> independent from the rest and possible to turn off...
>
>C99 does deprecate "const static":
>
>     6.11.5 Storage-class specifiers
>1    The placement of a storage-class specifier other than at the
>     beginning of the declaration specifiers in a declaration is
>     an obsolescent feature.
>
Hm, how about "inline"? GCC also just keeps quiet when a function (or 
prototype) is written as:

inline static int foo(int bar);



Jan Engelhardt
-- 
