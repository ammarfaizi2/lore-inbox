Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSHZKpr>; Mon, 26 Aug 2002 06:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSHZKpr>; Mon, 26 Aug 2002 06:45:47 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:23301 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318038AbSHZKpq>; Mon, 26 Aug 2002 06:45:46 -0400
Date: Mon, 26 Aug 2002 12:49:39 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: barrie_spence@agilent.com
Cc: andre@linux-ide.org, mru@users.sourceforge.net,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Message-ID: <20020826104939.GH1529@louise.pinerecords.com>
References: <C12D24916888D311BC790090275414BB0B724758@oberon.britain.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C12D24916888D311BC790090275414BB0B724758@oberon.britain.agilent.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 4:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying an append with LILO - I didn't realise that IDE was built as
> a module (I normally run SCSI :)). I've added "options ide-mod ide2=ata66
> ide3=ata66" to /etc/modules.conf, but that doesn't give me the forced
> messages and doesn't allow me to force it with hdparm.

I'm not sure about this but IIRC the entry in /etc/modules.conf has to be
options ide-mod options="ide2=ata66 ide3=ata66". So long as you don't get
the override warnings, nothing's changed.

If you're not booting off any IDE device you can try loading
the ide-mod by hand using the command that I've verified works.

T.
