Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWEZXys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWEZXys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWEZXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:54:48 -0400
Received: from keetweej.vanheusden.com ([213.84.46.114]:62603 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751110AbWEZXys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:54:48 -0400
Date: Sat, 27 May 2006 01:54:42 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-ID: <20060526235436.GD4294@vanheusden.com>
References: <348469535.17438@ustc.edu.cn>
	<20060525084415.3a23e466.akpm@osdl.org>
	<p73irns7uoh.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73irns7uoh.fsf@bragg.suse.de>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun May 28 01:15:59 CEST 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > These are nice-looking numbers, but one wonders.  If optimising readahead
> > makes this much difference to postgresql performance then postgresql should
> > be doing the readahead itself, rather than relying upon the kernel's
> > ability to guess what the application will be doing in the future.  Because
> > surely the database can do a better job of that than the kernel.
> With that argument we should remove all readahead from the kernel? 
> Because it's already trying to guess what the application will do. 
> I suspect it's better to have good readahead code in the kernel
> than in a zillion application.

Maybe a pluggable read-ahead system could be implemented.


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
