Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUBMAJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUBMAJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:09:44 -0500
Received: from smtp08.auna.com ([62.81.186.18]:18612 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S266598AbUBMAJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:09:40 -0500
Date: Fri, 13 Feb 2004 01:09:38 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with emu10k1 and gcc-3.4
Message-ID: <20040213000938.GC3966@werewolf.able.es>
References: <20040212231802.GG4092@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040212231802.GG4092@werewolf.able.es> (from jamagallon@able.es on Fri, Feb 13, 2004 at 00:18:02 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.13, J.A. Magallon wrote:
> Hi al...
> 
> I have tried to build 2.6.3-rc2-mm1 with gcc-3.4, and it works apart from this:
> 
> werewolf:/boot# modprobe emu10k1
> FATAL: Error inserting emu10k1 (/lib/modules/2.6.3-rc1-jam1-gcc34/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
> 
> dmesg:
> ...
> emu10k1: Unknown symbol strcpy
> 
> I think this solves the problem:
> 

Nope, that was not enough. Any ideas ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.3-rc2-jam1 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.1mdk))
