Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWEaWzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWEaWzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWEaWzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:55:19 -0400
Received: from mail.tmr.com ([64.65.253.246]:26277 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964821AbWEaWzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:55:18 -0400
Message-ID: <447E1F38.1050405@tmr.com>
Date: Wed, 31 May 2006 18:56:56 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222007.19456.s0348365@sms.ed.ac.uk> <44720CB6.7010908@zytor.com> <200605222015.01980.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605222015.01980.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

> It's a bit of a shame bzip2 even exists, really. It really would be better if 
> there was one unified, pluggable archiver on UNIX (and portables).
> 
All the people with slow connections bless bzip2. If you or someone want 
a new compressor, write a program for it, call it something unique so 
people will know it's different, and be happy.

Even with a fast line, I can only pull as fast as the source can push, 
so smaller is better for all of us. The time to decompress a tar.bz2 and 
tar.gz are very similar, the CPU for bzip2 is about double, and the time 
to create the directories and write the files is the same in either case.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

