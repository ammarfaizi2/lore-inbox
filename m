Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266452AbUFQLnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUFQLnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 07:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUFQLnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 07:43:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:16861 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266452AbUFQLnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 07:43:13 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
From: Andreas Schwab <schwab@suse.de>
X-Yow: First, I'm going to give you all the ANSWERS to today's test..
 So just plug in your SONY WALKMANS and relax!!
Date: Thu, 17 Jun 2004 13:41:59 +0200
In-Reply-To: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be> (Geert
 Uytterhoeven's message of "Wed, 16 Jun 2004 18:51:03 +0200 (MEST)")
Message-ID: <je3c4uqum0.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> I tried to add m68k support to `make checkstack', but got stuck due to my
> limited knowledge of complex perl expressions. I actually need to catch both
> expressions (incl. the one I commented out). Anyone who can help?

Untested:

  $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
