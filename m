Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265894AbUFIS1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265894AbUFIS1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUFIS1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:27:03 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3767 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265894AbUFIS1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:27:00 -0400
Date: Wed, 9 Jun 2004 20:27:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in ncpfs
Message-ID: <20040609182706.GC2950@wohnheim.fh-wedel.de>
References: <20040609122002.GD21168@wohnheim.fh-wedel.de> <Pine.LNX.4.60.0406091414140.14198@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.60.0406091414140.14198@winds.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 14:15:19 -0400, Byron Stanoszek wrote:
> 
> Jörn, do you have any analysis of stack usage for x86-64 or other 64-bit
> processors? I assume they would more readily reach the 4K stack boundaries 
> as all longs and pointers are 8 bytes instead of 4.

No I don't, the tool isn't even tested on anything but i386.  Do any
64bit architectures use 4k stacks?

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
