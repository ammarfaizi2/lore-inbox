Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGaTOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbTGaTOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:14:42 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:12943 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S267186AbTGaTOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:14:41 -0400
Subject: Re: TSCs are a no-no on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731183730.GA7803@mail.jlokier.co.uk>
References: <20030730135623.GA1873@lug-owl.de>
	 <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
	 <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de>
	 <20030730215032.GA18892@vana.vc.cvut.cz>
	 <1059606394.10505.24.camel@dhcp22.swansea.linux.org.uk>
	 <20030731151020.GF6410@mail.jlokier.co.uk>
	 <1059667304.16608.47.camel@dhcp22.swansea.linux.org.uk>
	 <20030731183730.GA7803@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059678643.17459.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 20:10:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-31 at 19:37, Jamie Lokier wrote:
> I wouldn't be surprised if even real CPUs mis-decode when there's a
> concurrent DMA into the area they are reading instructions from! :)

I believe there is a PIII errata about putting an instruction across 
a memory type boundary and executingit in a loop

