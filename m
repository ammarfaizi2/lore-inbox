Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFALcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTFALcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:32:04 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:63592 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id S264536AbTFALcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:32:03 -0400
Date: Sun, 1 Jun 2003 13:45:24 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@ep09.kernel.pl
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac1
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.50L.0306011336270.1596-100000@ep09.kernel.pl>
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Alan Cox wrote:
> o	First cut at making modular IDE happy again	(me)

hm, seems to ide stil broken ..

depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/ide                                            
/ide-core.o
depmod:         init_cmd640_vlb

hmm, but now init_cmd640_vlb is unresolved, not cmd640_vlb witch was a 
variable, now init_cmd640_vlb is function.
Hmm ... im going to read ide code again and maybe fix it (if i could ;))

--
Krzysiek Taraszka			(dzimi@pld.org.pl)
http://cyborg.kernel.pl/~dzimi/

