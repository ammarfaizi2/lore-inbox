Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUBQG5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266104AbUBQG5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:57:18 -0500
Received: from SMTP2.andrew.cmu.edu ([128.2.10.82]:43970 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S266099AbUBQG5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:57:11 -0500
Message-ID: <4031BB44.4080306@andrew.cmu.edu>
Date: Tue, 17 Feb 2004 01:57:08 -0500
From: Peter Nelson <pnelson@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PSX support in input/joystick/gamecon.c
References: <20040215222107.720832C2CC@lists.samba.org> <4031AB8D.1040209@andrew.cmu.edu> <200402170108.07271.dtor_core@ameritech.net>
In-Reply-To: <200402170108.07271.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> Nitpick: module_param, if module is compiled in, adds a prefix to 
> parameter
>
>names, so the parameters will be:
>gamecon.gc
>gamecon.gc_2
>gamecon.gc_3
>gamecon.gc_psx_delay
>gamecon.gc_psx_ddr
>
>At least with PSX stuff it would be nice to drop gc_ prefix. 
>  
>
Hopefully my last patch submission related to this file, here's an 
updated one using module_param_named so the external name is just psx_ 
(I'm leaving the internal name as gc_psx_ just for consistency with the 
rest of the file).

Thanks for the feedback,
-Peter
