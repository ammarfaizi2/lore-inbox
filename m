Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbULCLwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbULCLwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbULCLwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:52:02 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:51726 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262163AbULCLv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:51:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EGnvTq4u7R53Vo3jOSZn3qdJb+oEtt2S1un6T3MGpQhimcYG7GxbmNWb+r0Ydwa2cG/EwHPpry/r29a1hWqVfHqWUYYusLuC+ZGXE55sVmQqCijkhwNbsCDmTMeT72ORcbvU/YLjY0r4Qjtg8B4/t+VoF6a2P8KsDN3jQO+LTvI=
Message-ID: <5b64f7f041203035133c53d10@mail.gmail.com>
Date: Fri, 3 Dec 2004 06:51:57 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0412030834330.26749@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1101763996l.13519l.0l@werewolf.able.es>
	 <20041130071638.GC10450@suse.de>
	 <1101935773.11949.86.camel@nosferatu.lan>
	 <200412021723.48883.astralstorm@gorzow.mm.pl>
	 <Pine.LNX.4.53.0412030834330.26749@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004 08:35:32 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> > Ok, so I am a bit confused here.  We basically have 3 ways to use
> >> cdrecord on linux-2.6 without ide-scsi:
> >>
> >> 1) cdrecord dev=/dev/hdx
> >> 2) cdrecord dev=ATA
> >> 3) cdrecord dev=ATAPI
> >>
> >> Now, if I run all three and grep for '^Warning', I get:
> 
> Worse, yet, there is no DMA for any of these three :-(

Not true in 2.6. 1 definitely uses DMA now (disregard the damn
warning). And why would anyone use 2 or 3?

-Rahul
