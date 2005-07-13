Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVGMPkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVGMPkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVGMPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:40:14 -0400
Received: from relay03.pair.com ([209.68.5.17]:34318 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262668AbVGMPkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:40:12 -0400
X-pair-Authenticated: 24.126.76.52
Message-ID: <42D533B0.5090400@kegel.com>
Date: Wed, 13 Jul 2005 08:30:56 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_ALPHA_GENERIC problem with gcc-4.1
References: <42D27DAA.3040202@kegel.com>
In-Reply-To: <42D27DAA.3040202@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> I've been doing builds of linux-2.6.11 as a sanity check
> for new versions of gcc, and a problem just popped up
> in arch/alpha/Makefile (see 
> http://gcc.gnu.org/ml/gcc/2005-07/msg00397.html)

Never mind.  rth kindly explained to me that
it's a gcc or binutils problem.
The alpha kernel compiles in instructions
for ev6 machines even when building for generic/ev5,
and then uses them at runtime only if it
detects that it's safe.
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
