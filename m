Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUGGHbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUGGHbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUGGHbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:31:04 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:28585 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264936AbUGGHbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:31:02 -0400
Date: Wed, 7 Jul 2004 09:30:59 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707073059.GA20079@louise.pinerecords.com>
References: <1089165901.4373.175.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089165901.4373.175.camel@orca.madrabbit.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul-06 2004, Tue, 19:05 -0700
Ray Lee <ray-lk@madrabbit.org> wrote:

> According to K&R, 2nd ed, section A2.5.1 (Integer Constants):
>
>         The type of an integer depends on its form, value and suffix.
>         [...] If it is unsuffixed octal or hexadecimal, it has the first
>         possible of these types ["in which its value can be represented"
>         -- from omitted]: int, unsigned int, long int, unsigned long
>         int.

Is it safe to assume that C99 compilers append "..., long long int,
unsigned long long int" to the list?

-- 
Tomas Szepe <szepe@pinerecords.com>
