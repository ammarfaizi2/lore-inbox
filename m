Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVA0Vp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVA0Vp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVA0Vp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:45:26 -0500
Received: from hsp-51.hspserver.com ([193.254.213.110]:2459 "HELO
	hsp-51.hspserver.com") by vger.kernel.org with SMTP id S261203AbVA0VpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:45:20 -0500
Message-ID: <41F9610E.1000406@kamph.org>
Date: Thu, 27 Jan 2005 22:45:50 +0100
From: Timo Kamph <timo@kamph.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Viktor Horvath <ViktorHorvath@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: patches to 2.6.9 and 2.6.10 - make menuconfig shows "v2.6.8.1"
References: <1106851254.720.4.camel@Charon>
In-Reply-To: <1106851254.720.4.camel@Charon>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viktor Horvath wrote:
> Hello everybody,
> 
> today I patched myself up from 2.6.7 vanilla to 2.6.10 vanilla, but
> after all patches succeeded, "make menuconfig" shows "v2.6.8.1
> Configuration". Even worse, a compiled kernel calls in his bootlog
> himself "2.6.8.1". 

I guess you did somthing like this:

2.6.7 -patch-> 2.6.8 -patch-> 2.6.8.1 -patch-> 2.6.9 -patch-> 2.6.10.

And you didn't noticed that the 2.6.9 patch failed, because it is diffed 
against 2.6.8 and not 2.6.8.1!

If you do the patching without the 2.6.8.1 patch everything should be fine.


Timo
