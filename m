Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVBIIWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVBIIWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVBIIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:22:15 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:21935 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261802AbVBIIWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:22:11 -0500
Message-ID: <4209C82A.3090502@ens-lyon.org>
Date: Wed, 09 Feb 2005 09:22:02 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Michael Renzmann <mrenzmann@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
References: <4209C71F.9040102@web.de>
In-Reply-To: <4209C71F.9040102@web.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  0.3 UPPERCASE_25_50 message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Renzmann a écrit :
> Then we started to grep VERSION, PATCHLEVEL, SUBLEVEL and EXTRAVERSION 
> from the kernel's Makefile. This failed, since some distributors seem to 
> use shell commands for at least one of those. Example from SuSE 9.1:
> === cut ===
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 5
> EXTRAVERSION = -$(shell echo $(CONFIG_RELEASE)-$(CONFIG_CFGNAME))
> === cut ===
> 
> Newer kernels also allow to set CONFIG_LOCALVERSION in .config.

And you may also set some "localversion*" files in the source directory.
Their contents will be added too.

Brice

