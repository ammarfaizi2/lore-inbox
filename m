Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTBGOOl>; Fri, 7 Feb 2003 09:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTBGOOl>; Fri, 7 Feb 2003 09:14:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6307
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265276AbTBGOOk>; Fri, 7 Feb 2003 09:14:40 -0500
Subject: Re: Cyrix III processor and kernel boot problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: c1cc10@autistici.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E43C79A.2010506@autistici.org>
References: <3E43C79A.2010506@autistici.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044631346.14350.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Feb 2003 15:22:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 14:50, c1cc10 wrote:
> I've found out that the Cyrix III has no CMOV instruction and that this 
> could be the problem.

It is

gcc told to build for i686 assumes that cmov is present. Much of the 
code advantage for i686 comes from cmov so it makes sense to do that
I guess.

The optimal kernel for the CyrixIII/VIA-C3 is the the Cyrix III/VIA-C3
option in current kernel menus, or i486

Alan

