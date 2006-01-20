Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWATPlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWATPlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWATPk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:40:59 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:39396 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1750798AbWATPk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:40:59 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: RE: [PATCH 000 of 5] md: Introduction
Date: Fri, 20 Jan 2006 17:01:06 GMT
Message-ID: <0610HXV12@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> These can be mixed together quite effectively:
> You can have dm/lvm over md/raid1 over dm/multipath
> with no problems.
>
> If there is functionality missing from any of these recommended
> components, then make a noise about it, preferably but not necessarily
> with code, and it will quite possibly be fixed.

Also it's not Neil direct problem, since we are at it, the weakest point
about Linux MD is currently that ...
there is no production quality U320 SCSI driver for Linux to run MD over !

In the U160 category, the symbios driver passed all possible stress tests
(partly bad drives that require the driver to properly reset and restart),
but in the U320 category, neither the Fusion not the AIC79xx did.
