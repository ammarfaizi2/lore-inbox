Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVAaNM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVAaNM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVAaNM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:12:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61175 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261183AbVAaNFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:05:34 -0500
Date: Mon, 31 Jan 2005 13:04:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nix <nix@esperi.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
In-Reply-To: <87sm4izw3u.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com>
References: <87sm4izw3u.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005, Nix wrote:
> /proc/meminfo on my UltraSPARC IIi:
> Mapped:       18446744073687883208 kB
> 
> (This kernel is compiled with GCC-3.4.3, which might be relevant.)

Indeed: sparc64 gcc-3.4 seems to be having trouble with that
since 2.6.9: we've been persuing it offlist, I'll factor you in.

Hugh
