Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWBYCLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWBYCLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWBYCLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:11:55 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:61932 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964852AbWBYCLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:11:54 -0500
Date: Sat, 25 Feb 2006 03:11:52 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Message-ID: <20060225021152.GI1637@vanheusden.com>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<43FF26A8.9070600@keyaccess.nl>
	<m17j7kda52.fsf@ebiederm.dsl.xmission.com>
	<200602241748.39949.ak@suse.de>
	<m1wtfkbihh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wtfkbihh.fsf@ebiederm.dsl.xmission.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Feb 25 22:28:47 CET 2006
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about shuffeling the pages at runtime? Or are cachelines wired to
physical pages?

If not: group pages (even system-wide?) which are used most frequented.
Maybe with help from a userspace tool?


Folkert van Heusden

-- 
iPod winnen? --> http://keetweej.vanheusden.com/redir.php?id=62
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
