Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSJZVGy>; Sat, 26 Oct 2002 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJZVGy>; Sat, 26 Oct 2002 17:06:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261521AbSJZVGx>;
	Sat, 26 Oct 2002 17:06:53 -0400
Message-ID: <3DBB0553.5070805@pobox.com>
Date: Sat, 26 Oct 2002 17:12:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
References: <20021024163945.A21961@lucon.org> <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, WRT your implementation, the function you add is dead code if your 
new config variable is not set, which is not desireable at all.

WRT the overall idea, I would prefer to see what Linus and Martin Mares 
(and Ivan K) thought about it, before merging it.  The x86 PCI code is 
very touchy, and your patch has the potential to change driver probe 
order for little gain.

    Jeff




