Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWBOOXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWBOOXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBOOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:23:55 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51080 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932449AbWBOOXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:23:55 -0500
Message-ID: <43F3397B.3090207@de.ibm.com>
Date: Wed, 15 Feb 2006 15:23:55 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Horst Hummel <horst.hummel@de.ibm.com>,
       kernel <linux-kernel@vger.kernel.org>, heiko <heicars2@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, Martin <mschwid2@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ihno@suse.de
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
References: <1139935988.6183.5.camel@localhost.localdomain> <20060214190909.GA20527@lst.de>
In-Reply-To: <20060214190909.GA20527@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> As long as we backout the bogus eer
> patch before 2.6.16 all the cleanups and even the eckd ioctl fix
> can wait.  But don't put this crappy interface into 1.6.16 and thus
> SLES10 so that applications start to rely on it.
ACK: Given that a) both Horst and Christoph think the ioctl interface
needs cleanup but proposed cleanup interfers with existing
functionality (cmb), and b) later cleanup would change the
user-interface of eer, we should rush neither the ioctl change nor
eer into .16 until the maintainer is back afaics.

Carsten
-- 

Carsten Otte
IBM Linux technology center
ARCH=s390
