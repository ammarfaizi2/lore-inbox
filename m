Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVLHVOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVLHVOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVLHVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:14:24 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:8207 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932388AbVLHVOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:14:24 -0500
Message-ID: <4398A228.8050000@superbug.co.uk>
Date: Thu, 08 Dec 2005 21:14:16 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm1
References: <20051204232153.258cd554.akpm@osdl.org> <1134068983.21841.71.camel@localhost.localdomain>
In-Reply-To: <1134068983.21841.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Sun, 2005-12-04 at 23:21 -0800, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> 
> 
> In file included from sound/pci/ens1371.c:2:
> sound/pci/ens1370.c: In function `snd_audiopci_probe':
> sound/pci/ens1370.c:2462: error: `spdif' undeclared (first use in this
> function)sound/pci/ens1370.c:2462: error: (Each undeclared identifier is
> reported only once
> sound/pci/ens1370.c:2462: error: for each function it appears in.)
> sound/pci/ens1370.c:2462: error: `lineio' undeclared (first use in this
> function)
> make[2]: *** [sound/pci/ens1371.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> 
> 
> Thanks,
> Badari
> 

Thank you for the report, can you please raise a bug on 
http://bugzilla.kernel.org/
or
http://alsa-project.org/

We can then track this, and fix it.

FYI, I can reproduce the problem here already.


