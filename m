Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVCTNRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVCTNRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCTNRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:17:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14097 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262152AbVCTNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:17:39 -0500
Date: Sun, 20 Mar 2005 14:17:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>, vital@ilport.com.ua
Subject: Re: [PATCH] reduce inlined x86 memcpy by 2 bytes
Message-ID: <20050320131737.GD4449@stusta.de>
References: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

what do your benchmarks say about replacing the whole assembler code 
with a

  #define __memcpy __builtin_memcpy

?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

