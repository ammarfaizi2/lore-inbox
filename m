Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTAMSES>; Mon, 13 Jan 2003 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTAMSES>; Mon, 13 Jan 2003 13:04:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20378
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267954AbTAMSER>; Mon, 13 Jan 2003 13:04:17 -0500
Subject: Re: 2.4.20 Promise IDE RAID Locks up (gcc 3.2.1!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: freaky <freaky@bananateam.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002701c2bb2d$4f097ee0$1400a8c0@Freaky>
References: <006201c2b9ab$668e1950$1400a8c0@Freaky>
	 <1042330639.3826.2.camel@irongate.swansea.linux.org.uk>
	 <002701c2bb2d$4f097ee0$1400a8c0@Freaky>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042484366.19497.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 18:59:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 17:57, freaky wrote:
> One more ques... They told me they can't release open-source because it
> would make them lose their intellectual property. I was just thinking, if
> you build hardware, especially RAID controllers, doesn't that mean you
> sort-of bought a software RAID solution? That is, if their intellectual
> property is that much in their software? I feel like I might as well have
> gotten me a great linux supported IDE controller and use software RAID on
> it...

The analysis people (notably Arjan) have done strongly suggests that
they licensed their software raid stuff from someone as HPT and Promise
use a layout with a tiny mod, almost as if designed to be incompatible.

The big problem with raid people (hardware included) is that they want
desperately to keep their format controlled so that they can lock users
into their controllers unless the user is willing to do a full backup
and restore. In the hardware case people tend not to realise so much
that is all.

Alan

