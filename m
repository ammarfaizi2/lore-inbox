Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUCJOHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUCJOHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:07:10 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:58074 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262625AbUCJOG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:06:58 -0500
Message-ID: <404F20F5.6090406@softhome.net>
Date: Wed, 10 Mar 2004 15:06:45 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack allocation and gcc
References: <404F09C6.7030200@softhome.net> <200403101344.37171.baldrick@free.fr>
In-Reply-To: <200403101344.37171.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> It sounds like "stack alignment", which makes sure that
> every stack frame is aligned on a multiple of (for example)
> 32 bytes.  Check out -falign-functions.
> 

   -falign-function=1 -> No difference.

   And as 'info gcc' states it affects alignment of function entry points.

   '-mpreffered-stack-boundary=2' sort'a kind'a helped - I have reduced 
stack size of 108 bytes to 106 :-)

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|
