Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264193AbUDVQE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbUDVQE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUDVQE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:04:59 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:46049 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264207AbUDVQBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:01:23 -0400
Date: Thu, 22 Apr 2004 18:01:21 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kim Holviala <kim@holviala.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psmouse: fix mouse hotplugging 
In-Reply-To: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.55.0404221754470.16448@jurand.ds.pg.gda.pl>
References: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Horst von Brand wrote:

> > This patch fixes hotplugging of PS/2 devices on hardware which don't
> > support hotplugging of PS/2 devices. In other words, most desktop
> machines.
> 
> I have seen "hoplugging of mice" fry PS/2 ports, and heard of motherboards
> killed that way. 

 For older systems, a fuse would often blow on these ports, which
depending on the implementation would require a power cycle or a soldering
iron.  Then one of those PCxx specs from Microsoft required the PS/2 ports
to support hot-plugging, so chances are it may pretty safe with recent
equipment.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
