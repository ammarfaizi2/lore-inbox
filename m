Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTBGNcM>; Fri, 7 Feb 2003 08:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTBGNcM>; Fri, 7 Feb 2003 08:32:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3491
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264962AbTBGNcK>; Fri, 7 Feb 2003 08:32:10 -0500
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Mark Haverkamp <markh@osdl.org>,
       Steven Cole <elenstev@mesatop.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302061519360.14478-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302061519360.14478-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044628785.14350.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Feb 2003 14:39:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 23:22, Linus Torvalds wrote:
> On 6 Feb 2003, David Woodhouse wrote:
> > 
> > Cut and paste from xterm should work fine. Cut and paste from
> > gnome-terminal, OTOH, will often corrupt it for you.
> 
> I think xterm does the same thing. I certainly refuse to use inferior 
> clones (I don't understand why people even _bother_ with things like 
> gnome-terminal, since it can't even do proper vt100 sequences), and I 
> definitely get tab->space conversion between two xterms.

gnome-terminal should be an exact copy of the xterm codes without the
tek graphics extensions. Roughly speaking thats vt220. If you know of
any it gets wrong please file a bug report.

It should also be preserving tabs (WORKKSFORME 8)). People with 
replicable cases where it doesn't should stick them in gnome bugzilla.
https://bugzilla.gnome.org. Konsole should also have the same properties
as xterm with regard to these features.

Alan


