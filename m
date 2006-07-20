Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWGTPMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWGTPMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWGTPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:12:03 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:45340 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932585AbWGTPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:12:02 -0400
Date: Thu, 20 Jul 2006 08:12:02 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, tk@maintech.de
Subject: Re: + revert-pcmcia-make-ide_cs-work-with-the-memory-space-of-cf-cards-if-io-space-is-not-available.patch added to -mm tree
Message-ID: <20060720151202.GQ2038@hexapodia.org>
References: <200607090207.k6927S4D007223@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607090207.k6927S4D007223@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 07:07:28PM -0700, akpm@osdl.org wrote:
> The patch titled
>      revert "pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available"
> 
> ------------------------------------------------------
> Subject: revert "pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available"
> From: Andrew Morton <akpm@osdl.org>
> 
> Two reports (http://lkml.org/lkml/2006/6/15/155 and Pavel) of ide-cs breakage.
>  I'm suspecting it was this patch but have yet to have confirmation from Pavel
> or Andy (hint).

I finally got a chance to test, and 2.6.18-rc1-mm2 does fix my PCMCIA.
Thanks!

-a ndy
