Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbTDBPhF>; Wed, 2 Apr 2003 10:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbTDBPhF>; Wed, 2 Apr 2003 10:37:05 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:64008 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S263035AbTDBPhB>; Wed, 2 Apr 2003 10:37:01 -0500
Message-ID: <3E8B0648.1010800@didntduck.org>
Date: Wed, 02 Apr 2003 10:48:24 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: module.c broken in latest snapshot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/module.c: In function `check_modstruct_version':
kernel/module.c:845: warning: passing arg 2 of `__find_symbol' from 
incompatible pointer type
kernel/module.c:845: warning: passing arg 3 of `__find_symbol' from 
incompatible pointer type
kernel/module.c:847: warning: passing arg 5 of `check_version' from 
incompatible pointer type
kernel/module.c:847: too many arguments to function `check_version'
kernel/module.c: In function `load_module':
kernel/module.c:1276: structure has no member named `num_syms'

--
				Brian Gerst

