Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVBJHGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVBJHGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVBJHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:06:51 -0500
Received: from smtp06.web.de ([217.72.192.224]:35217 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S262033AbVBJHGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:06:40 -0500
Message-ID: <420B07FA.7050309@web.de>
Date: Thu, 10 Feb 2005 08:06:34 +0100
From: Michael Renzmann <mrenzmann@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
References: <4209C71F.9040102@web.de> <35297.194.237.142.7.1107985448.squirrel@194.237.142.7>
In-Reply-To: <35297.194.237.142.7.1107985448.squirrel@194.237.142.7>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sam Ravnborg wrote:
>>But... what is the right way to do this?
> I think you are looking for:
> make kernelrelease

otaku@gimli linux-2.6.10 $ make kernelrelease
make: *** No rule to make target `kernelrelease'.  Stop.
otaku@gimli linux-2.6.10 $ cd ..
otaku@gimli src $ cd linux-2.4.28
otaku@gimli linux-2.4.28 $ make kernelrelease
make: *** No rule to make target `kernelrelease'.  Stop.
otaku@gimli linux-2.4.28 $

I don't think this will help.

Including the kernel's Makefile also is no option, I think ("rulespace 
pollution").

Bye, Mike
