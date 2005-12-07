Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVLGHEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVLGHEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVLGHEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:04:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030313AbVLGHEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:04:07 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: Luke-Jr <luke-jr@utopios.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200512070702.38437.luke-jr@utopios.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org>
	 <1133880581.4836.37.camel@laptopd505.fenrus.org>
	 <200512070702.38437.luke-jr@utopios.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 08:03:52 +0100
Message-Id: <1133939032.2869.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 07:02 +0000, Luke-Jr wrote:
> On Tuesday 06 December 2005 14:49, Arjan van de Ven wrote:
> > Sure. But that doesn't mean there is no purchase power. HP, Dell and IBM
> > and co DO have purchasing power over NVidia and ATI. If they tell ATI or
> > NVidia to either go open source (unlikely) or rearchitect their drivers
> > to do the "hot IP" in userspace, it will happen.
> 
> Proprietary code in userspace is not much better.

Actually yes it is a lot better. Maybe it's not perfect, especially when
it talks to hardware, but in general userland code won't be able to
crash the machine, and is far less sensitive to internal changes to the
kernel. Userland applications are also independent works and are
isolated from eachother when they run. As long as you don't need them
for your system to boot..  Needing a userspace "driver" for 3D stuff is
a bit less optimal than the regular userland application, because it
voids some of the advantages I listed above, but it still is a heck of a
lot better than doing it in kernel land....

