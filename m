Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVBJI3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVBJI3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVBJI3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:29:44 -0500
Received: from smtp07.web.de ([217.72.192.225]:42638 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S262048AbVBJI3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:29:38 -0500
Message-ID: <420B1B6E.2060406@web.de>
Date: Thu, 10 Feb 2005 09:29:34 +0100
From: Michael Renzmann <mrenzmann@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
References: <4209C71F.9040102@web.de> <35297.194.237.142.7.1107985448.squirrel@194.237.142.7> <420B07FA.7050309@web.de> <200502100854.37606.agruen@suse.de>
In-Reply-To: <200502100854.37606.agruen@suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andreas Gruenbacher wrote:
> A backward-compatible replacement for the new kernelrelease (which was added 
> only 8 weeks ago) rule is:
> 
> echo -e 'foo:\n\t@echo $(KERNELRELEASE)\ninclude Makefile' \
>     | make -f-

Thanks a lot, that works great!

Bye, Mike
