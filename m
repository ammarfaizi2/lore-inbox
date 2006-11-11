Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424560AbWKKL5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424560AbWKKL5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424562AbWKKL5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:57:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42471 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424560AbWKKL5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:57:40 -0500
Subject: Re: wanted: more informative message if root device can't be
	found/mounted
From: Arjan van de Ven <arjan@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20061111114436.GA10020@aepfle.de>
References: <20061111085200.GA4167@amd64.of.nowhere>
	 <20061111114436.GA10020@aepfle.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 11 Nov 2006 12:57:37 +0100
Message-Id: <1163246257.3293.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 12:44 +0100, Olaf Hering wrote:
> On Sat, Nov 11, jurriaan wrote:
> 
> > kernel panic - unable to mount root device 09:02
> 
> These numbers are the root cause.
> Use mount by filesystem UUID. On-disk content does unlikely change.
> And if it does, you have to reconfigure the bootloader anyway.
> 
> All this luxury doesnt belong into the kernel.

one thing that we should consider is to not panic(). Panic() tends to
cause the backscroll capability to go away.. which is rather useful to
see what went wrong for this scenario...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

