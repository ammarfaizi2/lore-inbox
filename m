Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUASHcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 02:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUASHcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 02:32:18 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:32719 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264437AbUASHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 02:32:18 -0500
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: ekoome@kpmg.co.ke
Subject: Re: Kernel 2.6.1 compilation error
From: James Lamanna <jlamanna@ugcs.caltech.edu>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sun, 18 Jan 2004 23:32:31 -0800
Message-ID: <opr10hwhbkz4tciz@192.168.1.1>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1329 1665 1659 (parallel[ (set (reg:SI 0 eax)
> (asm_operands ("") ("=a") 0[ (reg:DI 1 edx)
<snip>

Not a kernel bug, per se, but a gcc one.
I couldn't help but notice you are using gcc 2.96.
2.96 is notorious for being broken so I would suggest changing your gcc 
version and giving it another shot.
