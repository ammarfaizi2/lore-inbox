Return-Path: <linux-kernel-owner+w=401wt.eu-S932188AbXAFWrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbXAFWrn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbXAFWrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:47:43 -0500
Received: from adsl-64-172-73-26.dsl.lsan03.pacbell.net ([64.172.73.26]:1876
	"EHLO myri.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbXAFWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:47:42 -0500
X-Greylist: delayed 1911 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 17:47:42 EST
Message-ID: <45A01D76.8080009@myri.com>
Date: Sat, 06 Jan 2007 23:06:46 +0100
From: Brice Goglin <brice@myri.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3: known unfixed regressions (v4)
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070106210417.GA20714@stusta.de>
In-Reply-To: <20070106210417.GA20714@stusta.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
> that are not yet fixed in Linus' tree.
>   

I reported another one yesterday, about HT MSI capability lookup being
broken (can only find the first one in the chain). See
http://lkml.org/lkml/2007/1/5/215. The patch works well here, but I
didn't get any comment so far.

The regression has been confirmed by Robert Hancock.

Brice

