Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTEZMkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTEZMkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 08:40:52 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:11528 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264358AbTEZMkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 08:40:51 -0400
Date: Mon, 26 May 2003 14:54:00 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030526125400.GA11873@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at> <200305221731.00900.m.c.p@wolk-project.de> <3ECDCB26.90400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECDCB26.90400@web.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Sven Krohlas wrote:

> Hi,
> 
> > http://people.freebsd.org/~gibbs/linux/SRC/
> > nothing more to say.
> 
> One Question:
> Is this patch only for problems with the aic79xx driver?
> I don't have such a device and it seems I've got similar Problems, too.
> My SCSI controller is a LSI Logic / Symbios Logic 53c875 (rev 26).

That chips needs a different driver (and has in fact three drivers to
choose from, the old ncr53c8xx, the old sym53c8xx, the new sym53c8xx_2).
It has nothing to do with aic7xxx.
