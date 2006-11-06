Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753168AbWKFOGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbWKFOGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbWKFOGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:06:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:44738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753168AbWKFOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:06:10 -0500
Message-ID: <454F414F.8020802@anagramm.de>
Date: Mon, 06 Nov 2006 15:06:07 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20375 (SATA150 TX2plus) doesn't work with last kernels.
References: <233976e40611040503m2a4bf449k78f84b0768d1f14e@mail.gmail.com> <233976e40611052238u4dfa9bdek83c74494b7163b39@mail.gmail.com>
In-Reply-To: <233976e40611052238u4dfa9bdek83c74494b7163b39@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean!

> So, I've investigated to see why UBUNTU Dapper see my IDE disk and why
> newer kernels doesn't. There's some big changes in dmesg : a
> sata_promise PATA port is found. Or it's on this port IDE disk is
> plugged.
> ---------------------
> Is there any PATA support broken in new sata_promise/libata stuff ? Is
> there any good kernel configuration in order to make it works?

It's not broken, it's just not included yet.

There is a patch somewhere out there, which could fix your issue.
Just to give it a name, it's something like:

linux-2.6-sata-promise-pata-ports.patch

I patched a 2.6.18.1 and didn't run into any troubles with it with
lots of i/o. So, i take it as "works for me". But Jeff knows when it's
the right time to push that. :-)

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
