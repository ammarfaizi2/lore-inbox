Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264376AbRF1VAA>; Thu, 28 Jun 2001 17:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbRF1U7t>; Thu, 28 Jun 2001 16:59:49 -0400
Received: from u-234-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.234]:53236
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S264323AbRF1U7c>; Thu, 28 Jun 2001 16:59:32 -0400
Date: Thu, 28 Jun 2001 22:59:08 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: james bond <difda@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIG PROBLEM
Message-ID: <20010628225908.A7816@bacchus.dhis.org>
In-Reply-To: <LAW2-F118HsRsWg8ubZ000077c1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LAW2-F118HsRsWg8ubZ000077c1@hotmail.com>; from difda@hotmail.com on Thu, Jun 28, 2001 at 06:49:46PM -0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 06:49:46PM -0000, james bond wrote:

> 1-systeme hangs when i try ton compile anything
> 
> i've  compiled the kernel 2.4.4 , once i finish and boot the first time on 
> 2.4.4 everything goses ok ,
> only too problemes
> 1st-  klogd takes 100%  CPU time

Some versions of the 3c59x driver emit a NUL character on bootup which makes
klogd suck CPU.  This is fixed in 2.4.5, dunno about 2.4.4.

  Ralf
