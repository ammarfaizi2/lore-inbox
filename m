Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWGBSFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWGBSFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWGBSFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:05:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24253 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964841AbWGBSFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:05:17 -0400
Message-ID: <44A80AB5.9060101@zytor.com>
Date: Sun, 02 Jul 2006 11:04:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? --	usr/klibc/exec_l.c:59:	undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>	 <1151788673.3195.58.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>	 <1151789342.3195.60.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>	 <1151826131.3111.5.camel@laptopd505.fenrus.org>	 <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>	 <1151861523.3111.19.camel@laptopd505.fenrus.org>	 <44A80471.1020406@zytor.com> <1151862632.3111.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1151862632.3111.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>>
>> Obviously, but at that time we should enable -fno-stack-protector vs 
> 
> -fno-stack-protector doesn't even exist afaics; simply because gcc has
> this as a positive commandline option only..

You actively have to fight gcc's internals to make a boolean option 
positive only, and that's a good thing.  The only reason it's possible 
at all are as a way to deal with multistate options.

	-hpa
