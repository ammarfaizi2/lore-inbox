Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWH2Lz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWH2Lz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWH2Lz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:55:57 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:41634 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S964965AbWH2Lz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:55:56 -0400
Date: Tue, 29 Aug 2006 13:55:37 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Nathan Lynch <ntl@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060829115537.GA24256@aepfle.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, Linus Torvalds wrote:

> Pls test it out, and please remind all the appropriate people about any 
> regressions you find (including any found earlier if they haven't been 
> addressed yet).

> Nathan Lynch:
>       [POWERPC] Fix gettimeofday inaccuracies

Tested on B&W G3, iBook1 and a G4/466.
This patch causes deadlocks on ppc32, but not on ppc64. Have to verify
it on a vanilla kernel, but I'm sure there are no funky patches in
openSuSE.

https://bugzilla.novell.com/show_bug.cgi?id=202146
