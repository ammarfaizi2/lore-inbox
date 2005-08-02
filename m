Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVHBPmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVHBPmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVHBPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:42:04 -0400
Received: from dsl3-63-249-67-69.cruzio.com ([63.249.67.69]:42141 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S261578AbVHBPlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:41:03 -0400
Date: Tue, 2 Aug 2005 08:41:03 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508021541.j72Ff3xH025830@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I said:
>Daniel Walker said:
>>You might want to enable slab debugging. Here's how,
>OK thanks. I think I'll also switch to 2.6.13rc4 just in case it's something that's
>already been fixed. Am compiling a slab debug 13rc4 now...

Which dies at boot before writing /var/log/messages. So I tried my slab debug
12.3 and of course I changed other things in the config (it was a generic
include-everything config so I trimmed some stuff out) and now its rock solid!  :-/

I don't have a copy of the ooopsing 12.3 config (I forgot to change the name
when I made the debugging one). Is it worth my looking at this or is 12.3
falling too far behind? I see 2.6.13rc5 is out now...
