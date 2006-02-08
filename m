Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWBHBb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWBHBb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWBHBb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:31:58 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:5534 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1030403AbWBHBb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:31:58 -0500
Message-ID: <43E94A02.2080205@vilain.net>
Date: Wed, 08 Feb 2006 14:31:46 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Schubert <bernd-schubert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
References: <200602080212.27896.bernd-schubert@gmx.de>
In-Reply-To: <200602080212.27896.bernd-schubert@gmx.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:
> Hi, 
> 
> just wanted to upgrade from 2.6.13 to 2.6.15, but there is a really BIG 
> problem. I just can't write into *some* directories and don't see the reason.
> 
> With 2.6.15:
> bathl:~# touch /var/run/test
> touch: cannot touch `/var/run/test': Permission denied
> 
> With 2.6.13:
> bathl:~# touch /var/run/test
> (No error message)

Some ideas; ACLs, SELinux, Attributes, Capabilities.

Sam.
