Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271443AbTGQL6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271442AbTGQL6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:58:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23758
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271441AbTGQL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:57:51 -0400
Subject: Re: 2.6 sound drivers?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: ookhoi@humilis.net, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       eugene.teo@eugeneteo.net
In-Reply-To: <3F168920.8080007@wmich.edu>
References: <20030716225826.GP2412@rdlg.net>
	 <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net>
	 <1058426808.1164.1518.camel@workshop.saharacpt.lan>
	 <20030717085704.GA1381@eugeneteo.net> <s5hu19lzevt.wl@alsa2.suse.de>
	 <20030717111958.GB30717@favonius>  <3F168920.8080007@wmich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058443806.8615.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 13:10:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 12:31, Ed Sweetman wrote:
> > Wouldn't esd (the enlightment sound daemon) take care of this in
> > userspace? I can have sound out of xmms, firebird, mpg321 and mplayer at
> > the same time with esd.
> 
> Most people would rather not use esd, especially when you dont need to 
> use any userspace deamon to do the job.

There are lots of reasons for not using esd (its sucky frequency code
for example) but you do need a userspace daemon because the alsa kernel
side mixing stuff doesn't handle network connections - and nor would you
want it to.

X is a networked environment, Gnome is a networked desktop, therefore
you need networked audio

