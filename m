Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUD0TFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUD0TFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUD0TFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:05:22 -0400
Received: from piedra.unizar.es ([155.210.11.65]:5316 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S264296AbUD0TDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:03:35 -0400
From: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
Reply-To: koke@sindominio.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 21:03:21 +0200
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, Grzegorz Kulewski <kangur@polcom.net>
References: <20040427165819.GA23961@valve.mbsi.ca> <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net> <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
In-Reply-To: <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404272103.21925.koke_lkml@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Martes, 27 de Abril de 2004 20:54, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Apr 2004 19:53:39 +0200, Grzegorz Kulewski said:
> > Maybe kernel should display warning only once per given licence or even
> > once per boot (who needs warning about tainting tainted kernel?)
>
> If your kernel is tainted by 3 different modules, it saves you 2 reboots
> when trying to replicate a problem with an untainted kernel.
>

what about something like a /proc/tainted list of modules?

> Other than that, there's probably no reason to complain on a re-taint.
