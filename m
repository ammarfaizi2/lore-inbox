Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUD0TQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUD0TQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUD0TQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:16:35 -0400
Received: from [80.72.36.106] ([80.72.36.106]:10120 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264308AbUD0TQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:16:34 -0400
Date: Tue, 27 Apr 2004 21:16:25 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: koke@sindominio.net
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <200404272103.21925.koke_lkml@amedias.org>
Message-ID: <Pine.LNX.4.58.0404272113110.9618@alpha.polcom.net>
References: <20040427165819.GA23961@valve.mbsi.ca>
 <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net>
 <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
 <200404272103.21925.koke_lkml@amedias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Jorge Bernal (Koke) wrote:
> On Martes, 27 de Abril de 2004 20:54, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 27 Apr 2004 19:53:39 +0200, Grzegorz Kulewski said:
> > > Maybe kernel should display warning only once per given licence or even
> > > once per boot (who needs warning about tainting tainted kernel?)
> >
> > If your kernel is tainted by 3 different modules, it saves you 2 reboots
> > when trying to replicate a problem with an untainted kernel.
> >
> 
> what about something like a /proc/tainted list of modules?

I think that /proc/tainted would be better than spamming logs after each 
load of tainted module...
But probably modules should not be removed from /proc/tainted on unloading 
(to prevent from "un-tainting" the kernel by "clever" users).


Grzegorz Kulewski

