Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGZSKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTGZSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:10:29 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:30155 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S262439AbTGZSKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:10:23 -0400
Date: Sat, 26 Jul 2003 21:25:24 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Orm Finnendahl <finnendahl@folkwang-hochschule.de>,
       linux-kernel@vger.kernel.org
Subject: Re: make menuconfig and 2.4.22-pre8
Message-ID: <20030726182524.GO150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Gene Heskett <gene.heskett@verizon.net>,
	Orm Finnendahl <finnendahl@folkwang-hochschule.de>,
	linux-kernel@vger.kernel.org
References: <20030726171527.GA1173@finnendahl.de> <200307261342.17010.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261342.17010.gene.heskett@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 01:42:16PM -0400, you [Gene Heskett] wrote:
> On Saturday 26 July 2003 13:15, Orm Finnendahl wrote:
> >
> >grisey:/usr/src# tar -xjf ~orm/install/linux-2.4.21.tar.bz2
> >grisey:/usr/src# rm -f linux
> 
> you are out of order with the above 2 lines.  Remove the link first, 
> then unpack and rename the new kernel.

Nowadays linux-x.x.x.tar.gz unpacks into linux-x.x.x directory, so it
shoudn't matter.

> >grisey:/usr/src# ln -s linux-2.4.21 linux

Instead of "rm -f; ln -s" you could do "ln -nfs".


-- v --

v@iki.fi
