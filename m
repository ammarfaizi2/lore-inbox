Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263937AbTCWVqm>; Sun, 23 Mar 2003 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263940AbTCWVp0>; Sun, 23 Mar 2003 16:45:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44710
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263937AbTCWVop>; Sun, 23 Mar 2003 16:44:45 -0500
Subject: Re: [PATCH] fix powerbook media bay
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: paulus@samba.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <15998.10367.608276.488022@nanango.paulus.ozlabs.org>
References: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
	 <1048433932.10727.18.camel@irongate.swansea.linux.org.uk>
	 <15998.10367.608276.488022@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048460903.10712.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 23:08:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 21:34, Paul Mackerras wrote:
> Is the IDE stuff still in the middle of open-heart surgery?  I'm happy
> to hack on it and send you patches if it isn't all going to change
> dramatically in the next week anyway.

Its on the crash trolley right now, but we think we may be able to save
the patient. The registration is saner now for PCI but not for the non
PCI cases. In addition the resource allocation is ass backwards and that
I will change at some point so the caller does the resource work.
PC9800 requires this really, PCMCIA badly needs it, and it lets me
remove a ton of hacks from the mmio aware drivers.

Alan

