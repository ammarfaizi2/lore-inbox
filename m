Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUGIQXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUGIQXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUGIQXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:23:12 -0400
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:48807 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S265029AbUGIQXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:23:09 -0400
Message-ID: <40EEC64B.1080907@246tNt.com>
Date: Fri, 09 Jul 2004 18:22:35 +0200
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Kumar Gala <kumar.gala@motorola.com>
Subject: Re: [PATCH 1/2] Freescale MPC52xx support for 2.6 - Base part
References: <40ED7C51.90103@246tNt.com> <17F799EA-D13C-11D8-A787-000393DBC2E8@freescale.com> <40EDE70C.40202@246tNt.com> <D3F66906-D1BF-11D8-B72C-000393DBC2E8@freescale.com>
In-Reply-To: <D3F66906-D1BF-11D8-B72C-000393DBC2E8@freescale.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kumar Gala wrote:

>> > A few comments:
>> >
>> > cputable.c: * the 8280/52xx, maybe we should just have G2_LE, (same
>> > core exists in 8272, 8249, etc.)
>>
>> IMHO, yes it may be better.
>
>
>> > mpc52xx_setup.c: * what is cpu_52xx[]?
>>
>> A table with coefficients taken from datasheet. They're used to
>> compute the core frequency according to XLB bus frequency and external
>> jumper configurations.
>
>
> Mind adding the above as a comment in the code.  :)


Ok, I'll change the G2_LE and change the name/add a small comment to 
cpu_52xx.
I'll repost a new updated set of patch monday morning with just that if 
I got no other comments.


Sylvain Munaut
