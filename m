Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285415AbRLSS6R>; Wed, 19 Dec 2001 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282497AbRLSS6I>; Wed, 19 Dec 2001 13:58:08 -0500
Received: from sammy.netpathway.com ([208.137.139.2]:20233 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S283724AbRLSS5w>; Wed, 19 Dec 2001 13:57:52 -0500
Message-ID: <3C20E330.EDA31ACA@netpathway.com>
Date: Wed, 19 Dec 2001 12:57:52 -0600
From: Gary White <linux-kernel@netpathway.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem here, but fixed with reiserfsck --rebuild-tree ...

> Is your reiserfs root partition 3.5 or 3.6 format? (can be checked in
/proc/fs/reiserfs/.../version

Mine is 3.6.26 but I don't have that info in my proc...Show info not
compiled in kernel

>
> Try to boot of different media (rescue disk/CD) and run resiserfsck on
your root partition,

Did so and found errors

>
> is there any errors? If yes - then fix them (with reiserfsck
--rebuild-tree probably),

Ran  reiserfsck --rebuild-tree and system now boots


> Is your root partition big?

No,  4GB

