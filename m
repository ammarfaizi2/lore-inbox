Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWJHRTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWJHRTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWJHRTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:19:43 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:24971 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751290AbWJHRTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:19:42 -0400
Date: Sun, 8 Oct 2006 19:19:40 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Hugo Vanwoerkom <rociobarroso@att.net.mx>
Cc: ocilent1@gmail.com, Chris Wedgwood <cw@f00f.org>,
       linux list <linux-kernel@vger.kernel.org>, ck@vds.kolivas.org,
       Lee Revell <rlrevell@joe-job.com>, dsd@gentoo.org
Subject: Re: [ck] Re: sound skips on 2.6.18-ck1
Message-ID: <20061008171940.GA30095@rhlx01.fht-esslingen.de>
References: <200606181204.29626.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org> <44BE37E8.2040706@att.net.mx> <45281E90.2080502@att.net.mx> <452924D3.9070907@att.net.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452924D3.9070907@att.net.mx>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 08, 2006 at 11:18:27AM -0500, Hugo Vanwoerkom wrote:
> I know nothing about quirks.c but I adapted the patch that worked (TM) 
> under 2.6.17 to 2.6.18 and it solves the situation for me.
> I attach the reworked patch and my lspci.

[...diff...]

Ah, right, that stuff.

IIRC that VIA on-board off-board on-again thing has still been rearing
its ugly head after 2.6.17, with a longish recent discussion on LKML
(~3 weeks ago?) where people were annoyed that it still had so many different
ways of breaking no matter how hard you tried to find a generic mechanism
that successfully applies to all devices out there.
As such I'm not surprised in the least that it's still not working for you.

Of course I don't know the thread by heart right now, but if you don't
manage to find it, then I'll try to dig it up.

Andreas Mohr
