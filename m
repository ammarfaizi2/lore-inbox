Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVBHAyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVBHAyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVBHAyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:54:46 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:7850 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261363AbVBHAyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:54:43 -0500
Date: Tue, 8 Feb 2005 01:56:30 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Drake <dsd@gentoo.org>, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
In-Reply-To: <20050207161810.23fcc4f1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0502080154200.31698@alpha.polcom.net>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org>
 <420801D7.3020405@gentoo.org> <20050207161810.23fcc4f1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Andrew Morton wrote:

> Daniel Drake <dsd@gentoo.org> wrote:
>>
>>> # fs/binfmt_elf.c
>>> #   2005/01/17 13:37:56-08:00 ecd@skynet.be +43 -19
>>> #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
>>> #
>>
>> I think so. For a short period we applied this patch to the Gentoo 2.6.10
>> kernel...
>>
>> http://dev.gentoo.org/~dsd/gentoo-dev-sources/release-10.01/dist/1900_umem_catch.patch
>>
>> ...but removed it once users complained it stopped kylix binaries from running.
>
> Bah.  That's what happens when you fix stuff.
>
> What's kylix?  The Borland C++ builder thing?

Rather Delphi (== Object Pascal) thing.


> How should one set about reproducing this problem?

IIRC, Some minimal "personal" version can be downloaded from borland.com.



Grzegorz Kulewski
