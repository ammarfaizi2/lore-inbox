Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWASFLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWASFLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbWASFLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:11:14 -0500
Received: from fsmlabs.com ([168.103.115.128]:16513 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030488AbWASFLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:11:13 -0500
X-ASG-Debug-ID: 1137647470-29057-16-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 18 Jan 2006 21:16:11 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gilles May <gilles@jekyll.org>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: SMP trouble
Subject: Re: SMP trouble
In-Reply-To: <43CAFF80.2020707@jekyll.org>
Message-ID: <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com>
References: <43CAFF80.2020707@jekyll.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.7533
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Gilles May wrote:

> I got a wierd problem with my dual Athlon box.
> The board is a K7D Master-L with 2 Athlon-MP 2800+ processors.
> Running it with SMP enabled in the kernel makes it freeze on heavy activity. I
> can always reproduce a freeze
> by watching a movie while copying files to/from USB disk, or on ping -f to a
> box on my LAN. Without SMP
> support in the kernel I can do this for hours and no freeze.
> The kernels I tried are ranging from 2.6.11-1.1369 (FC4) to 2.6.15 vanilla
> kernel. Running from console
> with no X nor any proprietary modules loaded.

Try booting the SMP kernel with 'noapic' kernel parameter and then send 
the kernel bootlog.
