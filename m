Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSCZVaf>; Tue, 26 Mar 2002 16:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312739AbSCZVaZ>; Tue, 26 Mar 2002 16:30:25 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27918 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S312498AbSCZVaV>;
	Tue, 26 Mar 2002 16:30:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Malcolm Mallardi <magamo@ranka.2y.net>
Date: Tue, 26 Mar 2002 22:27:36 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.19-pre4-ac1 vmware and emu10k1 problems
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9871A86516@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 02 at 16:06, Malcolm Mallardi wrote:
> The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
> under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
> counterparts.  Here is the errors that I get from vmware-config.pl:

> /lib/modules/2.4.19-pre4-ac1/build/include/linux/malloc.h:4: #error

As always... If you are using VMware3.0, get
ftp://platan.vc.cvut.cz/pub/vmware/vmware-ws-1455-update12.tar.gz.

If you are using VMware2.0, you can try
ftp://platan.vc.cvut.cz/pub/vmware/vmware-ws-1142-update1.tar.gz,
but please note that I'll not create any further VMware 2.0 patches,
so if you plan using VMware 2.0 on 2.5.x kernels, you can either
create patch yourself, or upgrade to VMware3, and also that this
patch is completely untested, as it does not compile under 2.5.7
at all ;-)
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

