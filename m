Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276701AbRJPUue>; Tue, 16 Oct 2001 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276702AbRJPUuY>; Tue, 16 Oct 2001 16:50:24 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:34517 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S276701AbRJPUuT>; Tue, 16 Oct 2001 16:50:19 -0400
Date: Tue, 16 Oct 2001 22:50:49 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org, "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug
Message-ID: <20011016225049.A996@online.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Justin T . Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <20011015222311.E2665@turing> <200110152031.f9FKVlY56104@aslan.scsiguy.com> <20011016181726.E935@turing> <20011016221645.A346@online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011016221645.A346@online.fr>
User-Agent: Mutt/1.3.22i
X-Operating-System: "debian SID Gnu/Linux 2.4.12 on i586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I switch ON the light in my brain and things are better now.

The PCI layer notify the driver that one of its devices has been
removed.
This is done with the remove function in the pci_driver struct.

In the case of the aic7xxx this is the function
ahc_linux_pci_dev_remove().

I should, at this point, precise that I use the driver v6.2.4.

I look in the code but it looks like this part of the code is broken.
Please Justin let me 1 month before starting looking at it. Otherwise I
have no chance to find a bug by myself.

Christophe 


-- 
Christophe Barbé <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
